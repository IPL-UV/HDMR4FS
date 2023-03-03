%%  HDMR LPP FATIH WITH ORTHOGONALIZATON
function [fs,W] = featureScoreHDMR(trn,polyNum,kNum)
%---------------
% This function returns the feature score based on the method proposed 
% at article.  
%
%---------------
% Inputs
%---------------
% trn --> Training data
% polyNum --> Degree of the Legendre polynomials
% kNum ---> Number of the neighbors for graph construction
%---------------
% Outputs
%---------------
% fs --> Feature scores 
% W ---> graph matrix
% t,s --> evaluation data
%---------------


% Construction of W Matrix Construction 
% Note that his configuration can be changed if desired. 
options                 = [];
%options.NeighborMode    = 'Supervised';
options.NeighborMode    = 'KNN';
%options.WeightMode      = 'Binary';
options.WeightMode      = 'HeatKernel'; % 'Cosine' %'Binary'
options.Metric          ='Euclidean';%
options.k               = kNum;
options.WeightMode      = 'Binary';


%% Construction of Graph Matrix 
options.k       = kNum;
X = trn;
lb              = min([X],[],1); % lower bound for integrations
ub              = max([X],[],1); % upper bound for integrations
XH              = myLegendre(X,polyNum,lb,ub)';
options.t       = mean(mean(XH));
W               = constructW(XH',options);
D               = full(diag(sum(W)));
L               = D-W; % graph Laplacian matrix 

%% Scalable HDMR Feature Selection 
for kk=1:size(X,2) 
    A1                  = XH((kk-1)*polyNum+1:kk*polyNum,:)*full(L)*(XH((kk-1)*polyNum+1:kk*polyNum,:))';
    [eigvec,lambda]     = eig(A1 + 0*eye(polyNum,polyNum));
    eigvec              = eigvec./max(eigvec, [], 1);   
    lambdaVec           = diag(lambda)';
    [a1,b1]             = sort(lambdaVec,'ascend');
    alphaMat(kk,:)      = (eigvec(:,b1(1)))';
end

%% Feature Ranking
if polyNum==1
    SI = sum(alphaMat.^2,2);
else
    SI = sum(alphaMat.^2,2);
end
[~,fs] = sort(SI,'descend');