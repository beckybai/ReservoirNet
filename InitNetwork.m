
function [Input, WMC, ForwardWeight] = InitNetwork()

Input.numNeurons = 1; 

% the WMC is a recurrent network with sparse connections
WMC.numNeurons = 1200;
WMC.prob = 0.1;

% the forward connections between two layers 
ForwardWeight.Input_WMC_gain = 1;
ForwardWeight.Input_WMC_prob = 0.1;

ForwardWeight.WMC_DM_gain = 0.02;

