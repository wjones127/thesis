data {
	int<lower=1> num_rides;
	int<lower=1> num_cyclists;
	int<lower=0,upper=1> rating[num_rides];
	int<lower=0> cyclist[num_rides];
	# ------ Ride-level Variables --------
	vector[num_rides] length;
	# ------ Cyclist-level Variables ----------
	vector[num_cyclists] cyclist_freq;
}
parameters {
  # ----- Ride-level Parameters ----------
	real beta_length;
	# ----- Cyclist-level Parameters --------
	real a_beta_freq;
	real a_beta_0; # intercept of the intercepts (WOAH)
	real<lower=0> sigma_a; # std dev of intercepts
	vector[num_cyclists] a; # Rider intercepts
}
model {
  vector[num_rides] cyclist_intercept;

	#priors on population parameters
	beta_length ~ normal(0,20);

	# Distribution for cyclist intercepts
	a_beta_0 ~ normal(0, 1);
	a_beta_freq ~ normal(0, 20);
	sigma_a ~ gamma(2,2);
  a ~ normal(a_beta_0 + a_beta_freq * cyclist_freq, sigma_a);

  for (i in 1:num_rides)
    cyclist_intercept[i] <- a[cyclist[i]];

  # Overall model
  rating ~ bernoulli_logit(cyclist_intercept + beta_length * length);
}
