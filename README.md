# BAM_online_analysis

BAM(Blab Alphaomega for Monkey), is used for loading AlphaOmega online data and do simple analysis during experiment. 

Developer: LiYipeng-Moon 

## How to use

1. Connect online analysis PC to AlphaOmega through a network switch. Power up AO, prepare your experiment task and subject.
2. Change the parameter in the code below and run it to generate 'default_params.mat'
    >  generate_params.m

3. Open 'BAM_Online_Loading.mlapp', once 'Start' is enable, click it and you will get saved data. You can change.
   
4. (Developing) Open 'BAM_Online_Analysis.mlapp', and select the neuron, dataset, session that you want to show, you can even select the functions in the image mat file to show (default is categorical selectivity and categorical PSTH)
   

## Wait to fix:

__fN_pre_register_data__. check the max memory for each digital channel, especially SEG channel()
__fN_miniun_prep__. Change electrode channel initialization and storing.
