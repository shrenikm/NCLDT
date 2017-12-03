%Function that computes initial wt for a new tree

%INPUTS
%Tnc_mag: Number of trees that have not connected to the target
%T_mag: Total number of trees
%q_root: New root node that is sampled
%q_n: The nearest node to the sampled root node
%q_ntc: The nearest node to the sampled root node that is a part of a
%connected tree. Value is -1 if no trees are connected
%q_end: End configuration

%OUTPUT
%wt: Initial direction the new tree should take


function [] = computeNewTreeDirection(Tnc_mag, T_mag, q_root, q_n, q_ntc, q_end)

wt = 0;
fp = 0;
a = 20;

%If no trees are connected, then the probability of the new node directing
%to the target = 1
if q_ntc == -1
    fp = 1;
    
else
    %x accounts for chances of the new root growing to the goal
    x = Tnc_mag/T_mag;
    delta = 10^-9;
    g1 = x/(x + delta);
    
    %y accounts for the chances of the new node growing to one of the
    %connected trees. Needs to override x if the sample configuration is
    %very close to a node in a connected tree
    
    d = norm(q_n - q_ntc);
    g2 = d/(a + d);
    
    fp = g1*g2;
    
end

%Now wt is computed using the probability values. A value is k is sampled
%from 1 to 100. If k <= fp*100, wt is set to the direction from the sampled
%root node to the goal

k = 1 + rand*99;
if k <= fp*100
    wt = (q_end - q_root)/norm(q_end - q_root);
else
    wt = (q_ntc - q_root)/norm(q_ntc - q_root);
end
    

