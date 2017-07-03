import numpy as np


def getStateValue(i, flux, W0):
    stateValue = np.power(flux, i) * W0
    return stateValue


def getTotalProb(K, flux, W0):
    totalProb = 0.0

    for i in range(K+1):
        totalProb += getStateValue(i, flux, W0)

    return totalProb


def getStateProb(K, flux, W0):
    probSum = getTotalProb(K, flux, W0)
    print "Total probability for K="+repr(K)+" = "+repr(probSum)
    for i in range(K+1):
        print "Probability of K="+repr(i)+" = " +\
              repr(np.divide(getStateValue(i, flux, W0), probSum))


lamb, micro, w0 = 5.0, 8.0, 1
flux = np.float64(np.divide(lamb, micro))
getStateProb(2, flux, w0)
getStateProb(5, flux, w0)
getStateProb(100, flux, w0)
