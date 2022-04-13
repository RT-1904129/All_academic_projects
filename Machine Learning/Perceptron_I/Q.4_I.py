from sklearn import datasets
from sklearn.model_selection import train_test_split
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

#This creates a dataset of 2 classes with 1000 sample points.
X, y = datasets.make_blobs(n_samples=1000,n_features=2,centers=2,cluster_std=1.05,random_state=2)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.5, random_state=42)

def step_function(z):
	if (z>0):
		return 1.0
	else:
		return 0.0


# This function represents a perceptron with X as Input space,y as labels. lr is the learning rate. iteration_list=Number of iterations.
# m,n are dimensions of X.

def perceptron(X, y, lr, iteration_list):
    m, n = X.shape
    #weight's initialization
    theta = np.zeros((n+1,1))

    #missed examples list
    no_of_misses_list = []

    for iteration in range(iteration_list):

        no_of_misses = 0

        # looping for every example.
        for idx, x_i in enumerate(X):

            # Insering 1 for bias, X0 = 1.
            x_i = np.insert(x_i, 0, 1)
            x_i = x_i.reshape(-1,1)

            # Calculating prediction/hypothesis.
            y_hat = step_function(np.dot(x_i.T, theta))

            # Updating if the example is misclassified.
            if (np.squeeze(y_hat) - y[idx]) != 0:
                theta += lr*((y[idx] - y_hat)*x_i)

                # Incrementing by 1.
                no_of_misses += 1

        # Appending number of misclassified examples
        # at every iteration.
        no_of_misses_list.append(no_of_misses)
        
    return theta, no_of_misses_list

def test_perceptron(X, y,theta):
	m, n = X.shape 
	no_of_misses = 0
	
	# looping for every example.
	for idx, x_i in enumerate(X):
	    
	    # Insering 1 for bias, X0 = 1.
	    x_i = np.insert(x_i, 0, 1)
	    x_i = x_i.reshape(-1,1)

	    # Calculating prediction/hypothesis.
	    y_hat = step_function(np.dot(x_i.T, theta))
	    
	    # Updating if the example is misclassified.
	    if (np.squeeze(y_hat) - y[idx]) != 0:
	    	no_of_misses += 1
	
	return (((m-no_of_misses)/m)*100)




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
plt.plot(X_test[:, 0][y_test==0], X_test[:, 1][y_test==0], "r^")
plt.plot(X_test[:, 0][y_test==1], X_test[:, 1][y_test==1], "bs")
plt.xlabel("feature 1")
plt.ylabel("feature 2")
plt.title("Perceptron Algorithm")

theta, miss_l = perceptron(X_train, y_train, 0.5, 100)
plot_decision_boundary(X, theta,1)
accuracy = test_perceptron(X_test, y_test,theta)
print("Accuracy for the model would be: ",accuracy)
plt.show()


"""
Observations:
Features used:X,Y,1
The 1000 samples are divided by the decision line perfectly.
i.e. the model is working fine.(For test and training data)
Theta is calculated using the step function and is updated at every misclassified example.
"""


