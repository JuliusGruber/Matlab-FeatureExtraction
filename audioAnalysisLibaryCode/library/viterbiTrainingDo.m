function [piTrained, ATrained, BTrained, AllProb] = viterbiTrainingDo(pi_init, A, B, TrainingSet, maxEpoch, mindiff)

% [piTrained, ATrained, BTrained, AllProb] = viterbiTrainingDo(pi_init, A, B, TrainingSet, maxEpoch, mindiff)
% Viterbi training (scaled version) of a Discrete Observation HMM
% when the training set consists of multiple training sequences.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities upon initialization.
%   A:              state transition matrix (initialization). 
%   B:              observation probability matrix (initialization). 
%   TrainingSet:    vector of cells. Each cell contains an
%                   observation sequence (sequence of discrete symbol ids).
%   maxEpoch:       maximum number of training epochs
%   mindiff:        minimum acceptable change between successive epochs
%
% RETURNS:
%   piTrained:      vector of initial state probalities at the output of
%                   the training stage.
%   ATrained:       state transition matrix at the output of the training stage.         
%   BTrained:       observation probability matrix at the output of the training stage.         
%   AllProb:        vector, each element of which contains the sum of the
%                   scaled Viterbi scores of all observation sequences at each iteration.
%
% (c) 2013 T. Giannakopoulos, A. Pikrakis


L=length(TrainingSet);
[M,N]=size(B);

theEpoch=1;
AllProb=[];
while theEpoch<=maxEpoch
    Atemp=zeros(N);
    Btemp=zeros(M,N);
    pitemp=zeros(N,1);
    MatchingProb=zeros(1,length(TrainingSet));
    i=1;
    while i<=L
        X=TrainingSet{i};
        [MatchingProb(i),BestPath]=scaledViterbiDisObs(pi_init,A,B,X);
        realPath=real(BestPath);
        for k=1:length(realPath)-1
            Atemp(realPath(k),realPath(k+1))=Atemp(realPath(k),realPath(k+1))+1;
        end
        for k=1:length(realPath)
            Btemp(X(k),realPath(k))=Btemp(X(k),realPath(k))+1;
        end
        pitemp(realPath(1))=pitemp(realPath(1))+1;
        i=i+1;
    end
    
    AllProb(theEpoch)=sum(MatchingProb); 
    
    if theEpoch>1 && abs(AllProb(theEpoch)-AllProb(theEpoch-1))<=mindiff
        % negligible difference between successive epochs
        break;
    end
    
    fprintf('Epoch : %d, Sum = %f\n',theEpoch,AllProb(theEpoch));
    
    
    pi_init=pitemp/sum(pitemp);
    
    [Nt,N]=size(Atemp);
    for k=1:N
        Atemp(k,:)=Atemp(k,:)/sum(Atemp(k,:));
    end
    A=Atemp;A(A==0)=A(A==0)+eps; % add a small number to zero probabilities
        
    for k=1:N
        Btemp(:,k)=Btemp(:,k)/sum(Btemp(:,k));
    end
    B=Btemp;B(B==0)=B(B==0)+eps; % add a small number to zero probabilities        
    
    theEpoch=theEpoch+1;
end

piTrained=pi_init;
ATrained=A;
BTrained=B;
