%% ENGN1735 Density Meter Project: function for evaluating FFT for raw photointerruter data (continuous signal)
% Input:
% t     - time domain (in s) -> vector of length N
%           - the first time is 0
%           - equidistant time steps
% x_t   - time function -> vector of length N
% modus - mode -> String
%   'pulse' -> transform of a pulse
%   'sinus' -> transform of a continuous signal
%   Background: The mode solely influences the normalization of the amplitude 
%   of the spectrum.
%
% Output:
% f   - frequency domain (in Hz) -> row vector
%       - length is N/2+1, if N is even
%       - length is (N+1)/2, if N is odd
%       - first frequency is 0
%       - equidistant frequency steps
% X_f - spectrum -> row vector
%       - length is N/2+1, if N even
%       - length is (N+1)/2, if N odd

function [f,X_f]=fourier(t,x_t,modus)
    % check if mode is set
    if nargin<3
        % set to default value
        modus='pulse';
    end
    
    % Number of values -> scalar
    N=length(t);

    % maximum time (in s) -> scalar
    t_max=t(N);
    % Time step (in s) -> scalar
    t_step=t(2);
    % maximum frequency (in Hz) -> scalar
    f_max=0.5/t_step;
        
    % perform Fourier transform -> vector of length N
    if strcmp(modus,'pulse')
        % the unit of the spectrum is 1/Hz (e.g. V/Hz, A/Hz, ...)
        XX(1:N)=t_max/(N-1)*fft(x_t);        
    elseif strcmp(modus,'sinus')
        % the unit of the spectrum is 1 (e.g. V, A, ...)
        XX(1:N)=2/N*fft(x_t);
    else
        error(['The modus ',modus,' is unknown.'])
    end
    % check whether N is even or odd
    if mod(N,2)
        % N is odd
        % create frequency spectrum -> row vector
        X_f(1:(N+1)/2)=XX(1:(N+1)/2);
        % create frequency range (in Hz) -> row vector
        f=linspace(0,f_max*(N-1)/N,(N+1)/2);
    else
        % N is even
        % create frequency spectrum -> row vector
        X_f(1:N/2+1)=XX(1:N/2+1);
        % create frequency range (in Hz) -> row vector
        f=linspace(0,f_max,N/2+1);
    end
end