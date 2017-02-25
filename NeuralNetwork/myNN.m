
type = 2; % 1 is autoencoder (AE), 2 is classifier

% load MNIST data
load('data4students.mat')

train_x = datasetInputs(1);
train_x = train_x{1,1};
train_y = datasetTargets(1);
train_y = train_y{1,1};

test_x = datasetInputs(2);
test_x = test_x{1,1};
test_y = datasetTargets(2);
test_y = test_y{1,1};

validate_x = datasetInputs(3);
validate_x = validate_x{1,1};
validate_y = datasetTargets(3);
validate_y = validate_y{1,1};
    
inputSize = size(train_x,2);%900
outputSize = size(train_y,2);%7, number of classes
hiddenActivationFunctions = {'ReLu','ReLu','ReLu','softmax'};
hiddenLayers = [500 500 1000 outputSize]; 

% parameters used for visualisation of first layer weights
visParams.noExamplesPerSubplot = 71; % number of images to show per row
visParams.noSubplots = floor(hiddenLayers(1) / visParams.noExamplesPerSubplot);
visParams.col = 30;% number of image columns
visParams.row = 30;% number of image rows

inputActivationFunction = 'linear'; %sigm for binary inputs, linear for continuous input


%normalise training data
train_mean = mean(train_x, 2);
train_std = std(train_x, 0, 2);
for i = 1 : size(train_x, 1)
    train_x(i, :) = (train_x(i, :) - train_mean(i)) / train_std(i);
end

%normalise test data
test_mean = mean(test_x, 2);
test_std = std(test_x, 0, 2);
for i = 1 : size(test_x, 1)
    test_x(i, :) = (test_x(i, :) - test_mean(i)) / test_std(i);
end

%normalise validation data
validate_mean = mean(validate_x, 2);
validate_std = std(validate_x, 0, 2);
for i = 1 : size(validate_x, 1)
    validate_x(i, :) = (validate_x(i, :) - validate_mean(i)) / validate_std(i);
end

%initialise NN params
nn = paramsNNinit(hiddenLayers, hiddenActivationFunctions);


% Set some NN params
%-----
nn.epochs = 20;

% set initial learning rate
nn.trParams.lrParams.initialLR = 0.01; 
% set the threshold after which the learning rate will decrease (if type
% = 1 or 2)
nn.trParams.lrParams.lrEpochThres = 10;
% set the learning rate update policy (check manual)
% 1 = initialLR*lrEpochThres / max(lrEpochThres, T), 2 = scaling, 3 = lr / (1 + currentEpoch/lrEpochThres)
nn.trParams.lrParams.schedulingType = 1;

nn.trParams.momParams.schedulingType = 1;
%set the epoch where the learning will begin to increase
nn.trParams.momParams.momentumEpochLowerThres = 10;
%set the epoch where the learning will reach its final value (usually 0.9)
nn.trParams.momParams.momentumEpochUpperThres = 15;

% set weight constraints
nn.weightConstraints.weightPenaltyL1 = 0;
nn.weightConstraints.weightPenaltyL2 = 0;
nn.weightConstraints.maxNormConstraint = 4;

% show diagnostics to monnitor training  
nn.diagnostics = 1;
% show diagnostics every "showDiagnostics" epochs
nn.showDiagnostics = 5;

% show training and validation loss plot
nn.showPlot = 1;

% use bernoulli dropout
nn.dropoutParams.dropoutType = 0;

% if 1 then early stopping is used
nn.earlyStopping = 0;
nn.max_fail = 10;

nn.type = type;

% set the type of weight initialisation (check manual for details)
nn.weightInitParams.type = 8;

% set training method
% 1: SGD, 2: SGD with momentum, 3: SGD with nesterov momentum, 4: Adagrad, 5: Adadelta,
% 6: RMSprop, 7: Adam
nn.trainingMethod = 2;
%-----------

% initialise weights
[W, biases] = initWeights(inputSize, nn.weightInitParams, hiddenLayers, hiddenActivationFunctions);

nn.W = W;
nn.biases = biases;

%train nn
[nn, Lbatch, L_train, L_val, clsfError_train, clsfError_val]  = trainNN(nn, train_x, train_y, validate_x, validate_y);


nn = prepareNet4Testing(nn);

% visualise weights of first layer
figure()
visualiseHiddenLayerWeights(nn.W{1},visParams.col,visParams.row,visParams.noSubplots);


[stats, output, e, L] = evaluateNNperformance( nn, test_x, test_y);
