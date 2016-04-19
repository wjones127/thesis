#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//



// [[Rcpp::export]]
std::vector<double> subsetSorted(NumericVector x, double lower, double upper)
{
//  int i = 0;
  std::vector<double> out;

  // Find where values start to be above lower bound
  NumericVector::iterator i = std::lower_bound(x.begin(), x.end(), lower);

  // Until the next value is above the upper bound, add it to the out vector
  out.push_back(i - x.begin());
  i++;
  while (upper > *i && i < x.end()) {
    out.push_back(i - x.begin());
    i++;
  }
  return out;
}


// [[Rcpp::export]]
double estimate_LOO_p(NumericVector x, NumericVector y, double width, int i)
{
  // Find which are in the window
  double lower = x[i] - width / 2;
  double upper = x[i] + width / 2;
  std::vector<double> in_window = subsetSorted(x, lower, upper);
  // Count total number in window
  double total = in_window.size() - 1;
  if (total == 0) return 0;
  else {
    // Count number of trues
    int count = 0;
    for (int j = 0; j < in_window.size(); j++) {
      if (y[in_window[j]] == 1.0 && in_window[j] != i) count++;
    }
    return count / total;
  }
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
x <- 1:100
subsetSorted(x, 10, 15)

x <- sort(runif(100, 0, 10))
y <- rbinom(100, 1, x / 10)
subsetSorted(x, 5, 25)
estimate_LOO_p(x, y, 4, 15)
estimate_LOO_p(x, y, 4, 40)
*/

