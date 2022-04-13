from sklearn import datasets
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import math
#This creates a dataset of 2 classes with 100 sample points.
X, y = datasets.make_circles(n_samples=100, shuffle=True, noise=None, random_state=None, factor=0.8)
X_squared = np.square(X)
new_X = np.append(X,X_squared,axis=1)#adding the new features of X^2 and Y^2 to the feature space.


def step_func(z):
	if (z>0):
		return 1.0
	else:
		return 0.0


# This function represents a perceptron with X as Input space,y as labels. lr is the learning rate. epochs=Number of iterations.
# m,n are dimensions of X.

def perceptron(X, y, lr, epochs):
    m, n = X.shape
    theta = np.zeros((n+1,1))#parameter initialization


    n_miss_list = [] #missed examples

    for epoch in range(epochs):
        a=0
        n=0
        n_miss = 0

        # looping for every example.
        for idx, x_i in enumerate(X):

            # Insering 1 for bias, X0 = 1.
            x_i = np.insert(x_i, 0, 1)
            x_i = x_i.reshape(-1,1)

            # Calculating prediction/hypothesis.
            #print(np.dot(x_i.T, theta))
            y_hat = step_func(np.dot(x_i.T, theta))

            # Updating if the example is misclassified.
            if (np.squeeze(y_hat) - y[idx]) != 0:
                theta += lr*((y[idx] - y_hat)*x_i)

                # Incrementing by 1.
                n_miss += 1

        # Appending number of misclassified examples
        # at every iteration.
        n_miss_list.append(n_miss)
        if epoch in [1,2,4,8,16,32,64,80,100]:
        	r1 = epoch/100


    return theta, n_miss_list






def plot_decision_boundary(theta ):

    # X --> Inputs
    # theta --> parameters


    # The equation of circle is x^2 + y^2 + 2*g*x + 2*f*y + c
    # What we get from perceptron theta0*b + theta1*x + theta2*y + theta3*x^2 + theta4*y^2
    #theta3 and theta4 should be equal for it to be circle
    # So the centre of this circle would be (-theta1/2*theta3,-theta2/2*theta3) with radius as sqrt((theta1/2*theta3)^2+(theta2/2*theta3)^2-(theta0/2*theta3))

    x=np.arange(-1,1,0.05)
    y=np.arange(-1,1,0.05)
    [X, Y] = np.meshgrid(x,y)
    Z=theta[4]*(Y**2) + theta[3]*(X**2) + theta[2]*(Y) + theta[1]*(X) + theta[0]

    # Plotting
    #print(X,Y,Z)

    plt.contour(X,Y,Z,levels=[0])

    #plt.gca().add_patch(circle1)
fig = plt.figure(figsize=(10,8))
plt.plot(X[:, 0][y==0], X[:, 1][y==0], "r^")
plt.plot(X[:, 0][y==1], X[:, 1][y==1], "bs")
plt.xlabel("feature 1")
plt.ylabel("feature 2")
plt.title("Perceptron Algorithm")
theta, miss_l = perceptron(new_X, y, 0.5, 100)
plot_decision_boundary( theta)
plt.show()

"""
Observations:
Features used:X,Y,X^2,Y^2,1
The 100 samples are divided by the decision boundary perfectly.
i.e. the model is working fine.
Theta is calculated using the step function and is updated at every misclassified example.
"""



