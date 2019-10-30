%Extract from Intuitive probability and random process using MATLAB Steven Kay Springer, 2006. 
%We have two books in the library
 
function SimMarkov()
    clear all
    rand('state',0)
    pstates = zeros(1,11)
    N=100000;  % set number of samples desired
    p0=[1 0 0 0 0 0 0 0 0 0]'; % set initial probability vector
    P = [ 
          0.2    0    0.8    0    0    0    0    0    0    0;
          0    0.2    0.3  0.3  0.2  0    0    0    0    0;
          0    0    0.1    0    0    0.9  0    0    0    0;
          0    0    0    0    0    0    1.0  0    0    0;
          0    0    0    0    0    0.3  0.7  0    0    0;
          0    0    0    0    0    0    0    0.2  0    0.8;
          0    0    0    0    0    0    0    0    0.8  0.2;
          1.0  0    0    0    0    0    0    0    0    0;
          0    1.0  0    0    0    0    0    0    0    0;
          0.2 0.6  0    0    0    0    0    0    0    0.2;
         ];
    xi=[0 1 2 3 4 5 6 7 8 9]'; % set values of PMF
    X0=PMFdata(1,xi,p0); % generate X[0] (see Appendix 6B for PMFdata.m 
                     % function subprogram)
    i=X0+1; % choose appropriate row for PMF
    X(1,1)=PMFdata(1,xi,P(i,:)); % generate X[1]
    i=X(1,1)+1; % choose appropriate row for PMF
    for n=2:N % generate X[n]
    i=X(n-1,1)+1; % choose appropriate row for PMF
    X(n,1)=PMFdata(1,xi,P(i,:));
    pstates(X(n,1) + 1) = pstates(X(n,1) + 1) + 1; 
    end
    pfinal = pstates ./ N
end
 
%  PMFdata.m
%
%  This program generates the outcomes for N trials 
%  of an experiment for a discrete random variable.
%  Uses the method of Section 5.9.  
%  It is a function subprogram.
%
%  Input parameters:
%
%    N   - number of trials desired
%    xi  - values of x_i's of discrete random variable (M x 1 vector)
%    pX  - PMF of discrete random variable (M x 1 vector)
%
%  Output parameters:
%
%    x   - outcomes of N trials (N x 1 vector)
%
function x=PMFdata(N,xi,pX)
M=length(xi);M2=length(pX);
    if M~=M2
    message='xi and pX must have the same dimension'
    end
    for k=1:M ; % see Section 5.9 and Figure 5.14 for approach used here
    if k==1
        bin(k,1)=pX(k); % set up first interval of CDF as [0,pX(1)]
   
    else
            bin(k,1)=bin(k-1,1)+pX(k); % set up succeeding intervals
                                   % of CDF
    end
    end  
    u=rand(N,1); % generate N outcomes of uniform random variable
    for i=1:N % determine which interval of CDF the outcome lies in
            % and map into value of xi
        if u(i)>0&u(i)<=bin(1)  
           x(i,1)=xi(1);
        end
        for k=2:M
           if u(i)>bin(k-1)&u(i)<=bin(k)
              x(i,1)=xi(k);
           end
        end
    end
end