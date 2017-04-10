
set recipe;
param dishname symbolic;

set nutrient;
set ingredient;

param ready_time{recipe};
param servings{recipe};
param score{recipe};

param recipenutrient{recipe, nutrient} >= 0, default 0;
param recipeingredient{recipe, ingredient} >= 0, default 0;