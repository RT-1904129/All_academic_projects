from sklearn import datasets
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

#This creates a dataset of 2 classes with 100 sample points.
X, y = datasets.make_blobs(n_samples=100,n_features=2,centers=2,cluster_std=1.05,random_state=2)


def step_function(z):
	if (z>0):
		return 1.0
	else:
		return 0.0


# This function represents a perceptron with X as Input space,y as labels. lr is the learning rate. iteration_list=Number of iterations.
# m,n are dimension of X.

def perceptron(X, y, lr, iteration_list):
    m, n = X.shape
    #weight's initialization
    theta = np.zeros((n+1,1))

    #missed examples list
    no_of_misses_list = []

    for iteration in range(iteration_list):

        no_of_misses = 0
        batch_grad = np.zeros((n+1,1))
        # looping for every example.
        for idx, x_i in enumerate(X):

            # Insering 1 for bias, X0 = 1.
            x_i = np.insert(x_i, 0, 1)
            x_i = x_i.reshape(-1,1)

            # Calculating prediction/hypothesis.
            y_hat = step_function(np.dot(x_i.T, theta))

            # Updating if the example is misclassified.
            if (np.squeeze(y_hat) - y[idx]) != 0:
                batch_grad += lr*((y[idx] - y_hat)*x_i)

                # Incrementing by 1.
                no_of_misses += 1
        theta = theta + batch_grad
        # Appending number of misclassified examples
        # at every iteration.
        no_of_misses_list.append(no_of_misses)
        if iteration in [1,2,4,8,16,32,64,80,100]:
        	r1 = iteration/100
        	plot_decision_boundary(X, theta,r1)
    return theta, no_of_misses_list






def plot_decision_boundary(X, theta,r):

    # X --> Inputs
    # theta --> parameters

    x1 = [min(X[:,0]), max(X[:,0])]
    m = -theta[1]/theta[2]
    c = -theta[0]/theta[2]
    x2 = m*x1 + c

    # Plotting

    plt.plot(x1, x2, 'y-',color=(1-r,r,0.1*r))

fig = plt.figure(figsize=(10,8))
plt.plot(X[:, 0][y==0], X[:, 1][y==0], "r^")
plt.plot(X[:, 0][y==1], X[:, 1][y==1], "bs")
plt.xlabel("feature 1")
plt.ylabel("feature 2")
plt.title("Perceptron Algorithm")
theta, miss_l = perceptron(X, y, 0.5, 100)
plt.show()

"""
Observations:
Features used:X,Y,1
The 100 samples are divided by the decision line perfectly.
i.e. the model is working fine.
Theta is calculated using the step function and is updated in batches.
"""


