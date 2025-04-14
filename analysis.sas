/* Step 1: Import the Dataset */
proc import datafile='/home/u63984450/winequality-red.csv'
    out=winequality
    dbms=csv
    replace;
    getnames=yes;
    delimiter=';';
run;

/* Step 2: Display the First 10 Rows */
proc print data=winequality (obs=10);
run;

/* Step 3: Descriptive Statistics */
proc means data=winequality n mean std min max;
run;

/* Step 4: Frequency Table for the Target Variable (quality) */
proc freq data=winequality;
    tables quality;
run;

/* Step 5: Pairwise Correlation Between All Features */
proc corr data=winequality;
run;

/* Simple Regression: Alcohol vs. Quality */
proc reg data=winequality;
    model quality = alcohol;
    output out=residuals_simple r=resid_simple p=predicted_simple;
    clb alpha=0.05; /* Confidence intervals for coefficients */
run;

/* Scatter Plot: Alcohol vs. Quality */
proc sgplot data=winequality;
    scatter x=alcohol y=quality;
    xaxis label="Alcohol";
    yaxis label="Quality";
    title "Scatter Plot of Alcohol vs. Quality";
run;


/* Multiple Linear Regression */
proc reg data=winequality;
    model quality = fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
                    free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol;
    output out=residuals r=resid p=predicted;
    clb alpha=0.05; /* Confidence intervals for coefficients */
run;

/* Scatter Plot Matrix for Key Variables */
proc sgscatter data=winequality;
    matrix fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
           free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol quality;
    title "Scatter Plot Matrix for Wine Quality Dataset";
run;


/* Plot Residuals vs. Fitted Values */
proc sgplot data=residuals;
    scatter x=predicted y=resid;
    refline 0 / axis=y lineattrs=(color=red);
    xaxis label="Fitted Values (Predicted)";
    yaxis label="Residuals";
    title "Residuals vs. Fitted Values";
run;

/* Q-Q Plot and Normality Test of Residuals */
proc univariate data=residuals normal;
    var resid;
    histogram / normal;
    qqplot / normal(mu=est sigma=est);
    title "Q-Q Plot and Normality Test of Residuals";
run;


/* Brown-Forsythe Test for Equal Variances */
data residuals_group;
    set residuals;
    if alcohol < 26 then group = 'Group 1: alcohol < 26';
    else group = 'Group 2: alcohol >= 26';
run;

proc anova data=residuals_group;
    class group;
    model resid = group;
    means group / hovtest=bf;
    title "Brown-Forsythe Test for Equal Variances";
run;

/* Bonferroni Joint Confidence Intervals */
proc reg data=winequality;
    model quality = fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
                    free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol;
    output out=residuals r=resid p=predicted;
    clb alpha=0.05;
run;


/* Forward Selection */
proc reg data=winequality;
    model quality = fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
                    free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol / selection=forward;
    output out=forward_output p=predicted;
run;


/* Backward Elimination */
proc reg data=winequality;
    model quality = fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
                    free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol / selection=backward;
    output out=backward_output p=predicted;
run;


/* Stepwise Selection */
proc reg data=winequality;
    model quality = fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
                    free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol / selection=stepwise;
    output out=stepwise_output p=predicted;
run;
		/* Perform Box-Cox Transformation */
		proc transreg data=winequality;
		    model boxcox(quality) = identity(fixed_acidity volatile_acidity citric_acid residual_sugar chlorides
		                                     free_sulfur_dioxide total_sulfur_dioxide density pH sulphates alcohol);
		run;
