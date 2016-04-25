data {
	int<lower=1> num_rides;
	int<lower=1> num_cyclists;
	int<lower=0,upper=1> rating[num_rides];
	int<lower=0> cyclist[num_rides];
	# ------ Ride-level Variables --------
	vector[num_rides] length;
	vector[num_rides] mean_temp;
	vector[num_rides] gust_speed;
	vector[num_rides] rainfall;
	vector[num_rides] rainfall_4h;
	# ------ Cyclist-level Variables ----------
	vector[num_cyclists] cyclist_freq;
	vector[num_cyclists] cyclist_weekend;
	vector[num_cyclists] cyclist_time_pc1;
	vector[num_cyclists] cyclist_time_pc2;
	vector[num_cyclists] cyclist_length_pc1;
	vector[num_cyclists] cyclist_length_pc2;
  vector[num_cyclists] cyclist_count_balance;
  vector[num_cyclists] cyclist_length_balance;
  vector[num_cyclists] cyclist_median_length;
  vector[num_cyclists] cyclist_median_length_diff;
  vector[num_cyclists] cyclist_var_length;
}
parameters {
  # ----- Ride-level Parameters ----------
	real beta_length;
	real beta_temp;
	real beta_gust;
	real beta_rainfall;
	real beta_rainfall4h;
	# ----- Cyclist-level Parameters --------
	real a_beta_freq;
	real a_beta_weekend;
	real a_beta_time1;
	real a_beta_time2;
	real a_beta_length1;
	real a_beta_length2;
	real a_beta_count_bal;
	real a_beta_length_bal;
	real a_beta_med_len;
	real a_beta_med_len_diff;
	real a_beta_var_len;
	real a_beta_0; # intercept of the intercepts (WOAH)
	real<lower=0> sigma_a; # std dev of intercepts
	vector[num_cyclists] a; # cyclist intercepts
}
model {
  vector[num_rides] cyclist_intercept;

	#priors on population parameters
	beta_length ~ normal(0,20);
	beta_temp ~ normal(0,20);
	beta_gust ~ normal(0,20);
	beta_rainfall ~ normal(0,20);
	beta_rainfall4h ~ normal(0,20);

	# Distribution for cyclist intercepts
	a_beta_0 ~ normal(0, 1);
	a_beta_freq ~ normal(0, 20);
	a_beta_weekend ~ normal(0, 20);
	a_beta_time1 ~ normal(0, 20);
	a_beta_time2 ~ normal(0, 20);
	a_beta_length1 ~ normal(0, 20);
	a_beta_length2 ~ normal(0, 20);
	a_beta_count_bal ~ normal(0, 20);
	a_beta_length_bal ~ normal(0, 20);
	a_beta_med_len ~ normal(0, 20);
	a_beta_med_len_diff ~ normal(0, 20);
	a_beta_var_len ~ normal(0, 20);
	sigma_a ~ gamma(2,2);
  a ~ normal(a_beta_0 + a_beta_freq * cyclist_freq + a_beta_weekend * cyclist_weekend +
            a_beta_time1 * cyclist_time_pc1 + a_beta_time2 * cyclist_time_pc2 +
            a_beta_length1 * cyclist_length_pc1 +
            a_beta_length2 * cyclist_length_pc2 +
            a_beta_count_bal * cyclist_count_balance +
            a_beta_length_bal * cyclist_length_balance +
            a_beta_med_len * cyclist_median_length +
            a_beta_med_len_diff * cyclist_median_length_diff +
            a_beta_var_len * cyclist_var_length, sigma_a);

  for (i in 1:num_rides)
    cyclist_intercept[i] <- a[cyclist[i]];

  # Overall model
  rating ~ bernoulli_logit(cyclist_intercept + beta_length * length +
                            beta_gust * gust_speed + beta_temp * mean_temp +
                            beta_rainfall * rainfall + beta_rainfall4h * rainfall_4h);
}
