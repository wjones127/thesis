data {
	int<lower=1> nY ; # num trials
	#int<lower=1> nB ; # num cyclists
	int<lower=0,upper=1> Y[nY] ; # ratings
	#vector[nY] rider ; # riders
	vector[nY] l ; # ride length
}
parameters {
	real intercept ; #population-level intercept
	real beta_length ; #population-level effect
	#vector[nB] Bintercept ; #variable to store each subject's intercept

}
model {
	#priors on population parameters
	intercept ~ normal(100,10) ;
	beta_length ~ normal(0,20) ;

	#assert sampling of subject-level parameters given population parameters
	#Bintercept ~ normal(intercept,intercept_sd) ;

	#assert sampling of trial-by-trial data given subject-level parameters and sigma
  #for(i in 1:nY){
	#	Y[i] ~ normal( Sintercept[S[ny]] + Seffect[S[ny]]*contrast[ny] , sigma ) ;
  #	}
  Y ~ bernoulli_logit(intercept + beta_length * l) ;

}
