#    allextetrominoes.py: Extended tetromino-like shapes
#    Copyright (C) 2024  Ramprasad S. Joshi
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# The classic tetrominoes are the first seven. Later, those shapes of four
# blocks joined on corners too are developed. There may be repetitions in
# these, but these are generated by an octave program that tried all possible
# 4x4 matrices that have four blocks joined on edges or corners. Thus, it
# is exhaustive. If you include these in your tetris (extetris, for extended
# tetris, if you may) then it becomes really much tougher.
# In order to include more of those extended shapes in your game, use the
# "get_any_extetromino(distribution)" call with the distribution that is
# either a list of indices (with frequencies of occurrences of each index
# giving its probability normalised by the length of the list)
# or just a range of indices (less than 74).

import numpy
Extetromino1=numpy.array([[True, True, True, True]]) # I
Extetromino2=numpy.array([[True, True], [True, True]]) # O
Extetromino3=numpy.array([[True, True, True], [True, False, False]]) # L
Extetromino4=numpy.array([[True, True, True], [False, True, False]]) # T
Extetromino5=numpy.array([[True, True, True], [False, False, True]]) # Gamma
Extetromino6=numpy.array([[False, True, True], [True, True, False]]) # S
Extetromino7=numpy.array([[True, True, False], [False, True, True]]) # Z
Extetromino8=numpy.array([[True, False, True], [False, True, True]])
Extetromino9=numpy.array([[True, True, False], [True, False, True]])
Extetromino10=numpy.array([[True, True, True, True]]) # I repeated for convenience
Extetromino11=numpy.array([[True, True, True, True]]) # I repeated for convenience
Extetromino12=numpy.array([[True, True, True, False], [False, False, False, True]])
Extetromino13=numpy.array([[True, True, False, True], [False, False, True, False]])
Extetromino14=numpy.array([[True, True, False, False], [False, False, True, True]])
Extetromino15=numpy.array([[True, False, True, True], [False, True, False, False]])
Extetromino16=numpy.array([[True, False, True, False], [False, True, False, True]])
Extetromino17=numpy.array([[True, False, False, True], [False, True, True, False]])
Extetromino18=numpy.array([[True, False, False, False], [False, True, True, True]])
Extetromino19=numpy.array([[False, True, True, False], [True, False, False, True]])
Extetromino20=numpy.array([[False, True, False, False], [True, False, True, True]])
Extetromino21=numpy.array([[False, False, True, False], [True, True, False, True]])
Extetromino22=numpy.array([[True, True], [True, False], [False, True]])
Extetromino23=numpy.array([[True, False], [True, True], [False, True]])
Extetromino24=numpy.array([[True, False], [False, True], [True, True]])
Extetromino25=numpy.array([[True, True, False], [False, True, False], [False, False, True]])
Extetromino26=numpy.array([[True, True, False], [False, False, True], [False, True, False]])
Extetromino27=numpy.array([[True, True, False], [False, False, True], [False, False, True]])
Extetromino28=numpy.array([[True, False, True], [False, True, False], [True, False, False]])
Extetromino29=numpy.array([[True, False, True], [False, True, False], [False, True, False]])
Extetromino30=numpy.array([[True, False, True], [False, True, False], [False, False, True]])
Extetromino31=numpy.array([[True, False, False], [True, True, False], [False, False, True]])
Extetromino32=numpy.array([[True, False, False], [True, False, True], [False, True, False]])
Extetromino33=numpy.array([[True, False, False], [True, False, False], [False, True, True]])
Extetromino34=numpy.array([[True, False, False], [False, True, True], [True, False, False]])
Extetromino35=numpy.array([[True, False, False], [False, True, True], [False, True, False]])
Extetromino36=numpy.array([[True, False, False], [False, True, True], [False, False, True]])
Extetromino37=numpy.array([[True, False, False], [False, True, False], [True, False, True]])
Extetromino38=numpy.array([[True, False, False], [False, True, False], [False, True, True]])
Extetromino39=numpy.array([[False, True, True], [True, False, False], [True, False, False]])
Extetromino40=numpy.array([[False, True, True], [True, False, False], [False, True, False]])
Extetromino41=numpy.array([[False, True, True], [False, True, False], [True, False, False]])
Extetromino42=numpy.array([[False, True, False], [True, True, False], [False, False, True]])
Extetromino43=numpy.array([[False, True, False], [True, False, True], [True, False, False]])
Extetromino44=numpy.array([[False, True, False], [True, False, True], [False, True, False]])
Extetromino45=numpy.array([[False, True, False], [True, False, True], [False, False, True]])
Extetromino46=numpy.array([[False, True, False], [True, False, False], [False, True, True]])
Extetromino47=numpy.array([[False, True, False], [False, True, True], [True, False, False]])
Extetromino48=numpy.array([[False, True, False], [False, True, False], [True, False, True]])
Extetromino49=numpy.array([[False, True, False], [False, False, True], [True, True, False]])
Extetromino50=numpy.array([[False, False, True], [True, True, False], [True, False, False]])
Extetromino51=numpy.array([[False, False, True], [True, True, False], [False, True, False]])
Extetromino52=numpy.array([[False, False, True], [True, True, False], [False, False, True]])
Extetromino53=numpy.array([[False, False, True], [True, False, True], [False, True, False]])
Extetromino54=numpy.array([[False, False, True], [False, True, True], [True, False, False]])
Extetromino55=numpy.array([[False, False, True], [False, True, False], [True, True, False]])
Extetromino56=numpy.array([[False, False, True], [False, True, False], [True, False, True]])
Extetromino57=numpy.array([[False, False, True], [False, False, True], [True, True, False]])
Extetromino58=numpy.array([[True, True, False, False], [False, False, True, False], [False, False, False, True]])
Extetromino59=numpy.array([[True, False, False, False], [False, True, True, False], [False, False, False, True]])
Extetromino60=numpy.array([[True, False, False, False], [False, True, False, True], [False, False, True, False]])
Extetromino61=numpy.array([[True, False, False, False], [False, True, False, False], [False, False, True, True]])
Extetromino62=numpy.array([[False, True, False, False], [True, False, True, False], [False, False, False, True]])
Extetromino63=numpy.array([[True, False], [True, False], [True, False], [False, True]])
Extetromino64=numpy.array([[True, False], [True, False], [False, True], [False, True]])
Extetromino65=numpy.array([[True, False], [False, True], [True, False], [False, True]])
Extetromino66=numpy.array([[True, False], [False, True], [False, True], [False, True]])
Extetromino67=numpy.array([[True, False, False], [True, False, False], [False, True, False], [False, False, True]])
Extetromino68=numpy.array([[True, False, False], [False, True, False], [False, True, False], [False, False, True]])
Extetromino69=numpy.array([[True, False, False], [False, True, False], [False, False, True], [False, True, False]])
Extetromino70=numpy.array([[True, False, False], [False, True, False], [False, False, True], [False, False, True]])
Extetromino71=numpy.array([[False, True, False], [True, False, False], [False, True, False], [False, False, True]])
Extetromino72=numpy.array([[True, False, False, False], [False, True, False, False], [False, False, True, False], [False, False, False, True]])
Extetromino73=numpy.array([[False, False, False, True], [False, False, True, False], [False, True, False, False], [True, False, False, False]])
def get_extetromino_at(index): # gives a sequential extetromino.
	return eval("Extetromino"+str(index))
def get_any_extetromino(distribution=range(1,74)):
	'''
		Returns a randomly selected extetromino from the above,
		according to the distribution. The distribution is given
		as a collection of indices, possibly with repetition
		Thus, the probabilities are decided by the ratio of the
		frequency of each index to the total length of the index
		sequence. The indices need not be in any order.
		Uniform distribution is achived by just range(count)
		where count is the total extetromino count.
	'''
	return eval("Extetromino"+str(distribution[numpy.random.randint(len(distribution))]))

def get_normal_distribution(distribution=range(1, 74)):
    '''
    Returns a distribution of indices of extetrominoes
    according to a normal distribution.
    '''
    # Generate a single random value from the normal distribution
    rand_index = int(numpy.random.normal(low=0, high=74, size=1))
    # Ensure the index is within the range of the distribution
    rand_index = min(max(rand_index, 0), len(distribution)-1)
    return eval("Extetromino" + str(distribution[rand_index]))

def get_uniform_distribution(distribution=range(1, 74)):
    '''
    Returns a distribution of indices of extetrominoes
    according to a uniform distribution.
    '''
    # Generate a single random value from the uniform distribution
    rand_index = int(numpy.random.uniform(low=0, high=74, size=1))
    # Ensure the index is within the range of the distribution
    rand_index = min(max(rand_index, 0), len(distribution)-1)
    return eval("Extetromino" + str(distribution[rand_index]))

def get_gamma_distribution(distribution=range(1, 74)):
    '''
    Returns a distribution of indices of extetrominoes
    according to a gamma distribution.
    '''
    # Generate a single random value from the gamma distribution
    rand_index = int(numpy.random.gamma(low=0, high=74, size=1))
    # Ensure the index is within the range of the distribution
    rand_index = min(max(rand_index, 0), len(distribution)-1)
    return eval("Extetromino" + str(distribution[rand_index]))

