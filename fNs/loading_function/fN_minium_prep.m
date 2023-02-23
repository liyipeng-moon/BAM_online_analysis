function [BAM_data, location_progress] = fN_minium_prep(BAM_config, BAM_data, pdata,datacapture)
        location_progress = zeros([1,length(BAM_data.interedted_channel_idx)]);
        for preprocessed_channel = 1:length(BAM_data.interedted_channel_idx)
            if(datacapture(preprocessed_channel)>2)
                switch BAM_data.ChannelName{preprocessed_channel}
                    case 'EventCode'
                        [ev_train,ev_time]=fN_sort_digital_port(pdata(preprocessed_channel,:), datacapture(preprocessed_channel),BAM_config.SR.DIO);
                        BAM_data.big_ev_train = fN_stack_array(BAM_data.big_ev_train, ev_train);
                        BAM_data.big_ev_time = fN_stack_array(BAM_data.big_ev_time, ev_time);
                        location_progress(preprocessed_channel) = BAM_data.big_ev_train.location;
                    case 'SEG1'
                        [spike_id, spike_time] = fN_sort_seg_port(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.SEG);
                        BAM_data.big_spk1_train = fN_stack_array(BAM_data.big_spk1_train, spike_id);
                        BAM_data.big_spk1_time = fN_stack_array(BAM_data.big_spk1_time, spike_time);
                        location_progress(preprocessed_channel) = BAM_data.big_spk1_time.location;
                    case 'LFP1'
                        [LFP_data, LFP_time] = fN_sort_analog_data(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.LFP);
                        BAM_data.big_LFP1_train = fN_stack_array(BAM_data.big_LFP1_train, LFP_data);
                        BAM_data.big_LFP1_time = fN_stack_array(BAM_data.big_LFP1_time, LFP_time);
                        location_progress(preprocessed_channel) = BAM_data.big_LFP1_time.location-1;
                    case 'LFP2'
                        [LFP_data, LFP_time] = fN_sort_analog_data(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.LFP);
                        BAM_data.big_LFP2_train = fN_stack_array(BAM_data.big_LFP2_train, LFP_data);
                        BAM_data.big_LFP2_time = fN_stack_array(BAM_data.big_LFP2_time, LFP_time);
                        location_progress(preprocessed_channel) = BAM_data.big_LFP2_time.location-1;
                    case 'SEG2'
                        [spike_id, spike_time] = fN_sort_seg_port(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.SEG);
                        BAM_data.big_spk2_train = fN_stack_array(BAM_data.big_spk2_train, spike_id);
                        BAM_data.big_spk2_time = fN_stack_array(BAM_data.big_spk2_time, spike_time);
                        location_progress(preprocessed_channel) = BAM_data.big_spk2_time.location;
                    case 'EYE1'
                        [EYE_data, EYE_time] = fN_sort_analog_data(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.AI);
                        BAM_data.big_EYE1_train = fN_stack_array(BAM_data.big_EYE1_train, EYE_data);
                        BAM_data.big_EYE1_time = fN_stack_array(BAM_data.big_EYE1_time, EYE_time);
                        location_progress(preprocessed_channel) = BAM_data.big_EYE1_time.location-1;
                    case 'EYE2'
                        [EYE_data, EYE_time] = fN_sort_analog_data(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.AI);
                        BAM_data.big_EYE2_train = fN_stack_array(BAM_data.big_EYE2_train, EYE_data);
                        BAM_data.big_EYE2_time = fN_stack_array(BAM_data.big_EYE2_time, EYE_time);
                        location_progress(preprocessed_channel) = BAM_data.big_EYE2_time.location-1;
                end
            end
        end


end