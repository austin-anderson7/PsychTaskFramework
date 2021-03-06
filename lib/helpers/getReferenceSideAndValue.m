function [ referenceSide, referenceValue ] = getReferenceSideAndValue(trialData, blockConfig)
% Check if there is any specific reference side & value defined for this trial,
% or for this block. If reference side is unavailable, generate it at random.

% Approach: Start from general options and overwrite with more specific ones

% a. Check in blockConfig
if isfield(blockConfig, 'runSetup') && isfield(blockConfig.runSetup, 'refSide')
  referenceSide = blockConfig.runSetup.refSide;
end

if isfield(blockConfig.trial.generate, 'reference')
  referenceValue = blockConfig.trial.generate.reference;
end

% b. check in trialData
% NOTE: trialData is, by convention, a table, so it doesn't respond to
% `isfield` - would have to convert to struct
trialVars = trialData.Properties.VariableNames;

if ismember('refSide', trialVars)
  referenceSide = trialData.refSide;
elseif ismember('referenceSide', trialVars)
  referenceSide = trialData.referenceSide;
end

if ismember('reference', trialVars)
  referenceValue = trialData.reference;
end

%% 2. Check values
if ~exist('referenceSide', 'var')
  referenceSide = randi(2);
  warning('Reference side not supplied; picking %d at random', referenceSide);
end

if ~exist('referenceValue', 'var')
  error('Reference value not set in either blockConfig or trialData!');
end
end
