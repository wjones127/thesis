<table style="text-align:center"><caption><strong>results</strong></caption>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="4"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="4" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="4">stressful</td></tr>
<tr><td style="text-align:left"></td><td><em>logistic</em></td><td colspan="3"><em>generalized linear</em></td></tr>
<tr><td style="text-align:left"></td><td><em></em></td><td colspan="3"><em>mixed-effects</em></td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">log_length</td><td>-0.123<sup>***</sup></td><td>-0.102<sup>***</sup></td><td>-0.104<sup>***</sup></td><td>-0.081<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(-0.179, -0.067)</td><td>(-0.168, -0.036)</td><td>(-0.171, -0.037)</td><td>(-0.149, -0.013)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">mean.temp</td><td>0.040</td><td>0.066<sup>*</sup></td><td>0.067<sup>*</sup></td><td>0.067<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(-0.014, 0.095)</td><td>(-0.004, 0.136)</td><td>(-0.003, 0.136)</td><td>(-0.003, 0.137)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">gust.speed</td><td>0.006<sup>*</sup></td><td>0.006</td><td>0.006</td><td>0.006</td></tr>
<tr><td style="text-align:left"></td><td>(-0.001, 0.013)</td><td>(-0.002, 0.014)</td><td>(-0.002, 0.014)</td><td>(-0.002, 0.014)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">rainfall</td><td>0.010</td><td>0.014</td><td>0.014</td><td>0.009</td></tr>
<tr><td style="text-align:left"></td><td>(-0.012, 0.032)</td><td>(-0.012, 0.040)</td><td>(-0.012, 0.040)</td><td>(-0.017, 0.035)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">rainfall.4h</td><td>0.012<sup>***</sup></td><td>0.014<sup>***</sup></td><td>0.014<sup>***</sup></td><td>0.016<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005, 0.020)</td><td>(0.006, 0.023)</td><td>(0.006, 0.023)</td><td>(0.007, 0.025)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">avg_log_length</td><td></td><td></td><td>0.098</td><td>0.058</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(-0.399, 0.595)</td><td>(-0.443, 0.559)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">weekend</td><td>-0.373<sup>***</sup></td><td>-0.302<sup>***</sup></td><td>-0.302<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td>(-0.518, -0.228)</td><td>(-0.464, -0.141)</td><td>(-0.463, -0.140)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(sin(2 * pi/one_day * time))</td><td></td><td></td><td></td><td>-0.203<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td>(-0.370, -0.036)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(cos(2 * pi/one_day * time))</td><td></td><td></td><td></td><td>-0.533<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td>(-0.747, -0.319)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(sin(4 * pi/one_day * time))</td><td></td><td></td><td></td><td>0.022</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td>(-0.136, 0.181)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(cos(4 * pi/one_day * time))</td><td></td><td></td><td></td><td>-0.366<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td>(-0.481, -0.252)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>-2.201<sup>***</sup></td><td>-3.021<sup>***</sup></td><td>-3.043<sup>***</sup></td><td>-3.443<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(-2.357, -2.046)</td><td>(-3.302, -2.739)</td><td>(-3.347, -2.739)</td><td>(-3.780, -3.106)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>15,333</td><td>15,333</td><td>15,333</td><td>15,333</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-5,220.389</td><td>-4,368.323</td><td>-4,368.248</td><td>-4,329.233</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>10,454.780</td><td>8,752.645</td><td>8,754.496</td><td>8,682.465</td></tr>
<tr><td style="text-align:left">Bayesian Inf. Crit.</td><td></td><td>8,813.747</td><td>8,823.236</td><td>8,774.118</td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="4" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>
