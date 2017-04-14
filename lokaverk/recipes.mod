set recipe;
set day;
set nutrient;
set ingredient;

param coeN;
param coeS;
param coeT;
param coeP;
param coeI;

param recipesPerPay;
param maxRepetition;

param ready_time{recipe};
param servings{recipe};
param score{recipe};
param price{recipe};

param recipenutrient{recipe, nutrient} >= 0, default 0;
param recipeingredient{recipe, ingredient} >= 0, default 0;
param numberofingredient{r in recipe} := sum{i in ingredient: recipeingredient[r,i] > 0} 1;

var x{day, recipe} binary;

subject to threeRecipesPerDay {d in day}: sum{r in recipe} x[d, r] = recipesPerPay;
subject to recipeMaxThreeTimes {r in recipe}: sum{d in day} x[d, r] <= maxRepetition;
		 
minimize objfunction:
  	  coeN * sum{d in day, n in nutrient} (100 - sum{r in recipe} recipenutrient[r, n]/servings[r]  * x[d,r])
	- coeS * sum{d in day, r in recipe} score[r] * x[d,r]
	+ coeT * sum{d in day, r in recipe} ready_time[r] * x[d,r]
  	+ coeP * sum{d in day, r in recipe} price[r] * x[d,r]
  	+ coeI * sum{d in day, r in recipe} numberofingredient[r] * x[d,r];
  