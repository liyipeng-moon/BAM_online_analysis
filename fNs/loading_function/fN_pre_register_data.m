function [BAM_data, max_save_memory] = fn_pre_register_data(BAM_config,BAM_data,app)
    % event code
    BAM_data.big_ev_train.val=nan([1,200]);BAM_data.big_ev_train.location=1;
    BAM_data.big_ev_time.val=nan([1,200]);BAM_data.big_ev_time.location=1;
    max_save_memory = [200];


lfp_memory_per_reading = floor(BAM_config.read_interval*BAM_config.SR.LFP*1.1);
lfp_memory_times_reading = floor(BAM_config.save_interval/BAM_config.read_interval);
eye_memory_per_reading = floor(BAM_config.read_interval*BAM_config.SR.AI*1.1);
eye_memory_times_reading = floor(BAM_config.save_interval/BAM_config.read_interval);
spk_memory = 3000;
    % seg1
    % can we change this to a function?
    if(BAM_config.ElectrodeUsing(1))
        % % LFP
        BAM_data.big_LFP1_train.val=nan([lfp_memory_times_reading,lfp_memory_per_reading]);BAM_data.big_LFP1_train.location=1;
        BAM_data.big_LFP1_time.val=nan([1, lfp_memory_times_reading]);BAM_data.big_LFP1_time.location=1;
        max_save_memory = [max_save_memory, lfp_memory_times_reading];

        % spk
        BAM_data.big_spk1_train.val=nan([1,2000]);BAM_data.big_spk1_train.location=1;
        BAM_data.big_spk1_time.val=nan([1,2000]);BAM_data.big_spk1_time.location=1;
        max_save_memory = [max_save_memory, spk_memory];
    end

    if(BAM_config.ElectrodeUsing(2))
        % LFP
        BAM_data.big_LFP2_train.val=nan([lfp_memory_times_reading,lfp_memory_per_reading]);BAM_data.big_LFP2_train.location=1;
        BAM_data.big_LFP2_time.val=nan([1, lfp_memory_times_reading]);BAM_data.big_LFP2_time.location=1;
        max_save_memory = [max_save_memory, lfp_memory_times_reading];

        % spk
        BAM_data.big_spk2_train.val=nan([1,2000]);BAM_data.big_spk2_train.location=1;
        BAM_data.big_spk2_time.val=nan([1,2000]);BAM_data.big_spk2_time.location=1;
        max_save_memory = [max_save_memory, spk_memory];
    end


    % eyeIn
    BAM_data.big_EYE1_train.val=nan([eye_memory_times_reading,eye_memory_per_reading]);BAM_data.big_EYE1_train.location=1;
    BAM_data.big_EYE1_time.val=nan([1, eye_memory_times_reading]);BAM_data.big_EYE1_time.location=1;
    max_save_memory = [max_save_memory, eye_memory_times_reading];
    
    BAM_data.big_EYE2_train.val=nan([eye_memory_times_reading,eye_memory_per_reading]);BAM_data.big_EYE2_train.location=1;
    BAM_data.big_EYE2_time.val=nan([1, eye_memory_times_reading]);BAM_data.big_EYE2_time.location=1;
    max_save_memory = [max_save_memory, eye_memory_times_reading];

end