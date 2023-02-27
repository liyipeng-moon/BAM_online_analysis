function[combined_data, BAM_config, BAM_analysis, app] = fN_find_valid_trial(combined_data, BAM_config, BAM_analysis, app)

combined_data = fN_summary_eye(combined_data, app);


%find onset
img_ev_idx = find(combined_data.ev_train>10000); % this is the location in event train
stimuli_idx = combined_data.ev_train(img_ev_idx); % this is the ev value
onset_idx = []; offset_idx = [];
for ii = 1:length(stimuli_idx)-1
    if(stimuli_idx(ii+1)-stimuli_idx(ii)==10000) % diff ev value = 10000
        onset_idx  = [onset_idx, img_ev_idx(ii)];
        offset_idx = [offset_idx, img_ev_idx(ii+1)]; % the idx is the location in event train
    end
end
onset_time = combined_data.ev_time(onset_idx);
offset_time = combined_data.ev_time(offset_idx);

valid_img = ones(size(onset_time));
time_thres = app.TimeSpinner.Value/100;

for img = 1:length(onset_idx)
    eye_within_onset = combined_data.valid_time_series(onset_time(img):offset_time(img));
    valid_img(img) = sum(eye_within_onset)/length(eye_within_onset)>time_thres;
end

app.ValidTrialGauge.Value = sum(valid_img);
app.ValidTrialGauge.Limits = [1,length(valid_img)];
app.ValidTrialGauge.MajorTicks = [1, floor([0.25,0.5,0.75,1]*length(valid_img))];

combined_data.valid_onset = onset_idx(find(valid_img));
combined_data.valid_onset;
end