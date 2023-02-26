function combined_data = fN_prep_and_stack_data(combined_data, temp_bam_data)

all_avai_data = fieldnames(temp_bam_data);
continue_flag = 0;
for field_now = 1:length(all_avai_data)
    if(continue_flag)
        continue
        % which means this channel is pre-processed in tha last for loop
    end
    continue_flag = 0;
    field_name = all_avai_data{field_now};
    if(strcmp(field_name(1:3),'big')) % useful channel
        switch field_name(5:7)
            case 'ev_'
                combined_data = fN_asign_ev_data(combined_data, getfield(temp_bam_data, field_name), field_name);
            case 'spk'
                spk_data = getfield(temp_bam_data, field_name); % spk data
                field_name = all_avai_data{field_now+1};
                spk_time = getfield(temp_bam_data, field_name); % spk time
                electrode_config = temp_bam_data.Electrode(str2num(field_name(8)),:);
                combined_data = fN_asign_spk_data(combined_data, spk_data, spk_time, electrode_config);
                continue_flag = 1;
            otherwise % lfp of eye

        end

    end
end


end






