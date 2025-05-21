
% BONO EEG preprocessing pipeline

% this script will perform all preprocessing steps in sequence. It will
% only stop if split sessions are found. 
%
% Note: the operations performed are irreversable. The pipeline will only
% work on the RCT1 data in it's original state, as certain pre-edits are
% made (see below) which irrevocably change (delete etc) pieces of data. 
%
% // WORK ON A COPY OF THE DATA, NOT THE ORIGINAL 

% path to the root folder containing site folders
path_preproc = '/Users/luke/Library/CloudStorage/OneDrive-King''sCollegeLondon/_shortcuts/Shared Documents - Safe Passage BONO/Data/2024_BONO EEG/2. Pre-processed data/02_preproc';
path_raw = '/Users/luke/Library/CloudStorage/OneDrive-King''sCollegeLondon/_shortcuts/Shared Documents - Safe Passage BONO/Data/2024_BONO EEG/1. Raw data from OWEY/Extracted_files/Aims-2-trials';

%     % 0. Pre edits
%     
%         rct1_make_pre_edits_to_data(path_raw);

    % 1. Walk through folders and make a list of all IDs 
    
        [results, ops] = PIP1_EEG_interrogate_folder_structure(path_raw);
        tab = teLogExtract(results);
        
        file_res_mat = fullfile(path_preproc, sprintf('BONE_EEG_pipe_results_%s.mat', datestr(now, 30)));
        file_res_xl = fullfile(path_preproc, sprintf('BONE_EEG_pipe_results_%s.xlsx', datestr(now, 30)));
        
        save(file_res_mat, 'results', 'ops', 'tab')
        writetable(tab, file_res_xl);
        
%         % remove wave2
%         tab = teLogExtract(results);
%         idx_wave2 = strcmpi(tab.visit, 'Timepoint_2');
%         tab(idx_wave2, :) = [];
%         results = structArray2cellArrayOfStructs(table2struct(tab));
%         fprintf('[PIP1_EEG_run_pipeline_v1]: removed %d datasets from wave2\n',...
%             sum(idx_wave2));
%             
%     % 2. Find split/multiple sessions 
%     
%         % find any split sessions
%         [results, ops, split_found, split_results] = tepFindSplitSessions(results);
%         
%         % if any are found, display them here and then stop -- they need
%         % to be fixed manually
%         if split_found
%             tab_split_results = teLogExtract(split_results);
%             fprintf(2, 'Split sessions found, cannot continue. Check and fix manually:\n\n');
%             disp(tab_split_results)
%             error('Split sessions found')
%         end
%         
%     % 3. Manually fix split sessions -- see documentation for details
%     
%         % see PIP1_EEG_join_fix_sessions
%         % see PIP1_EEG_combine_brainvision
%         
%     % 4. Check EEG and attention coding data are present
%     
%         [~, results] = tepCheckDataPresence(results,...
%             {'check_log', 'check_eyetracking', 'check_eeg'});
%         
%         results = PIP1_EEG_build_data_presence_status(results);
%         
%         % WIP -- need to check this function works as expected 
%         [results, ops_task_presence] = tepTaskPresence(results);
%         
%     % 4. Semi-manually correct missing event markers from the light sensor,
%     % where possible. 
%     
%         % ingest the results of manual light sensor edits 
%         [results, results_light_sensor, light_sensor_fixed_data] =...
%             PIP1_EEG_ingest_light_sensor(results, path_ls);
%         
%     % 5. Ingest CRF
%     
%         results = PIP1_EEG_join_ecrf_to_pipeline(results, path_crf);
%     
%     % 6. Export fieldtrip sessions
%     
%         results = PIP1_EEG_convert_all_data_to_fieldtrip(results, path_ft);
%         results = PIP1_EEG_save_fixed_light_sensor_data(...
%             results, results_light_sensor, light_sensor_fixed_data, path_ft);
%     
%     % 7. Save pipeline results
%     
%         tab = teLogExtract(results);
%         
%         filename = sprintf('PIP1_EEG_pipeline_results_%s', datestr(now, 30));
%         path_xlsx = fullfile(path_preproc, [filename, '.xlsx']);
%         path_mat = fullfile(path_preproc, [filename, '.mat']);
%     
%         save(path_mat, 'results', 'tab');
%         writetable(tab, path_xlsx)
%     
%     
%     
%     
%     
%     
%     
%     
