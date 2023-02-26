function[combined_data, BAM_config, BAM_analysis, app] = fN_find_valid_trial(combined_data, BAM_config, BAM_analysis, app)

combined_data = fN_summary_eye(combined_data, app);
img_ev_idx = find(combined_data.ev_train>10000);
combined_data.ev_train(img_ev_idx);
end