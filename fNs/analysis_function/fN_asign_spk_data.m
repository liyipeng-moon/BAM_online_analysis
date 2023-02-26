function combined_data = fN_asign_spk_data(combined_data, spk_data, spk_time, electrode_config)

if(spk_data.location==1)
    % which means there is no spike during saving_interval
    return
end
if(~isfield(combined_data,'spk'))
    combined_data.spk = struct;
    combined_data.spk(10000).location = []; % non-elegant way
end
all_unit = unique(spk_data.val(1:spk_data.location-1));
all_unit(all_unit==0)=[];
    for uu = 1:length(all_unit)
        location_of_spike = find(spk_data.val==all_unit(uu));
        time_of_spike = spk_time.val(location_of_spike);
        unit_id = electrode_config(all_unit(uu)).UID;
        if(isempty(combined_data.spk(unit_id).location))
            combined_data.spk(unit_id).location = time_of_spike;
        else
            combined_data.spk(unit_id).location = [combined_data.spk(unit_id).location, time_of_spike];
        end
    end
end
