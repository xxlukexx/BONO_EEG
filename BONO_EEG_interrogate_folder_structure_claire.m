function [res, ops] = BONO_EEG_interrogate_folder_structure_claire(path_raw)
% We define the folder structure that comes out of OWEY. Some folders
% contain useful info (e.g. site), others don't (e.g. modality) and are
% flagged to be ignored. Finally the session folder is flagged. 
%
% example: 
%   /Data
%       /2024_BONO EEG
%           /1. Raw data from OWEY
%               /Extracted_files
%                   /Aims-2-trials
%                       /PASS           
%                           /EEG
%                               /Stellenbosch
%                                   /Raw
%                                       /Timepoint_1   <- enter here
%                                           /<id folder>
%                                               /<session folder>

    folder_def = {...
%       folder name         ignore folder?      is session folder?
        'visit',            false,              false                   ;...
        'id',               false,              true                    ;... 
        };

    [res, ops] = tepInterrogateFolderStructure(path_raw, folder_def);
    
    % make table of results
    tab = teLogExtract(res);
    
    % convert table back to result structs
    res = structArray2cellArrayOfStructs(table2struct(tab));

end