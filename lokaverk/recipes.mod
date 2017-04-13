set recipe;
set day;
set nutrient;
set ingredient;

var x{day, recipe} binary;

param ready_time{recipe};
param servings{recipe};
param score{recipe};
param price{recipe};

param recipenutrient{recipe, nutrient} >= 0, default 0;
param recipeingredient{recipe, ingredient} >= 0, default 0;
param numberofingredient{r in recipe} := sum{i in ingredient: recipeingredient[r,i] > 0} 1;

subject to threeRecipesPerDay {d in day}: sum{r in recipe} x[d, r] = 3;
subject to recipeMaxThreeTimes {r in recipe}: sum{d in day} x[d, r] <= 3;
		 
minimize objfunction:
  	  1.00 * sum{d in day, n in nutrient} (100 - sum{r in recipe} recipenutrient[r, n]/servings[r]  * x[d,r])
	- 0.50 * sum{d in day, r in recipe} score[r] * x[d,r]
	+ 1.00 * sum{d in day, r in recipe} ready_time[r] * x[d,r]
  	+ 0.15 * sum{d in day, r in recipe} price[r] * x[d,r]
  	+ 5.00 * sum{d in day, r in recipe} numberofingredient[r] * x[d,r]
	;
  