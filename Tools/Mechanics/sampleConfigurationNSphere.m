function [qs] = sampleConfigurationNSphere(ndim, q1, epsilon_min, epsilon_max)

%Samples a random point within an n-sphere centered at q1
%We use general spherical coordinates for n-spheres to generate points in
%an n-sphere
%Such spherical coordinates only give points on the sphere. To include the
%space inside the sphere, we randomly initialize the radius to be a value
%in [epsilon_min, epsilon_max]

%The general configuration is constructed by creating a generator matrix
%with each row having separate sin and cos functions of the angles. The
%product of all elements of each row would then give the particular
%coordinate.

%Refer to https://en.wikipedia.org/wiki/N-sphere for mathematical details

r = epsilon_min + rand*(epsilon_max - epsilon_min);
theta = pi*rand(ndim - 1, 1);
theta(end) = 2*pi*rand;

gen_mat = ones(ndim, ndim - 1);

for i=1:ndim-1
    gen_mat(i, i) = cos(theta(i));
    for j=1:i-1
        gen_mat(i, j) = sin(theta(j));
    end
end

for j=1:ndim-1
    gen_mat(end, j) = sin(theta(j));
end

qs = q1 + r*prod(gen_mat, 2)';
