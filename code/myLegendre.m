% Generating the matrix A in Eq. (19) by using Legendre polynomials.

function    A = myLegendre(x,m,lb,ub)
%---------------
%This function returns Legendre extension of the data matrix.
% Note that this code is not optimized and use it with your 
% responsibility.
%---------------
% Inputs
%---------------
% x  --> Data matrix
% m  --> dimension
% lb --> Lower bound
% ub --> upper bound
%---------------
% Outputs
%---------------
% A ---> Extended data matrix
%---------------

n               = size(x,2);
A               = zeros(size(x,1),n*m);

% Defining Legendre Polynomials
phi{1}          = @(x)  x;
phi{2}          = @(x)  (1/2)*(-1 + 3*x.^2);
phi{3}          = @(x)  (5*x.^3)/2 - (3*x)/2;
phi{4}          = @(x)  (1/8)*(3 - 30*x.^2 +35*x.^4);
phi{5}          = @(x)  (1/8)*(15*x -70*x.^3 + 63*x.^5);
phi{6}          = @(x)  (1/16)*(-5 + 105*x.^2 - 315*x.^4 + 231*x.^6);
phi{7}          = @(x)  (1/16)*(-35*x + 315*x.^3 - 693*x.^5 + 429*x.^7);
phi{8}          = @(x)  (1/128)*(35 -1260*x.^2 + 6930*x.^4 - 12012*x.^6 + 6435*x.^8);
phi{9}          = @(x)  (1/128)*(315*x - 4620*x.^3 + 18018*x.^5 - 25740*x.^7 + 12155*x.^9);
phi{10}         = @(x) (46189*x.^10)/256 - (109395*x.^8)/256 + (45045*x.^6)/128 - (15015*x.^4)/128 + (3465*x.^2)/256 - 63/256;
phi{11}         = @(x)  (88179*x.^11)/256 - (230945*x.^9)/256 + (109395*x.^7)/128 - (45045*x.^5)/128 +...
                        (15015*x.^3)/256 - (693*x)/256;
phi{12}         = @(x) (676039*x.^12)/1024 - (969969*x.^10)/512 + ...
                        (2078505*x.^8)/1024 - (255255*x.^6)/256 + (225225*x.^4)/1024 - (9009*x.^2)/512 + 231/1024;
phi{13}         = @(x)  (1300075*x.^13)/1024 - (2028117*x.^11)/512 +...
    (4849845*x.^9)/1024 - (692835*x.^7)/256 + (765765*x.^5)/1024 - (45045*x.^3)/512 + (3003*x)/1024;
phi{14}         = @(x) (5014575*x.^14)/2048 - (16900975*x.^12)/2048 + ...
    (22309287*x.^10)/2048 - (14549535*x.^8)/2048 + (4849845*x.^6)/2048 -...
    (765765*x.^4)/2048 + (45045*x.^2)/2048 - 429/2048;
phi{15}         = @(x) (9694845*x.^15)/2048 - (35102025*x.^13)/2048 + (50702925*x.^11)/2048 - (37182145*x.^9)/2048 + ...
    (14549535*x.^7)/2048 - (2909907*x.^5)/2048 + (255255*x.^3)/2048 - (6435*x)/2048;
phi{16}         = @(x) (300540195*x.^16)/32768 - (145422675*x.^14)/4096 + (456326325*x.^12)/8192 - (185910725*x.^10)/4096 +...
    (334639305*x.^8)/16384 - (20369349*x.^6)/4096 + (4849845*x.^4)/8192 - (109395*x.^2)/4096 + 6435/32768;
phi{17}         = @(x) (583401555*x.^17)/32768 - (300540195*x.^15)/4096 + (1017958725*x.^13)/8192 - (456326325*x.^11)/4096 +...
    (929553625*x.^9)/16384 - (66927861*x.^7)/4096 + (20369349*x.^5)/8192 - (692835*x.^3)/4096 + (109395.*x)/32768; 
phi{18}         = @(x) (2268783825*x.^18)/65536 - (9917826435*x.^16)/65536 + (4508102925*x.^14)/16384 -...
     (4411154475*x.^12)/16384 + (5019589575*x.^10)/32768 - (1673196525*x.^8)/32768 + (156165009*x.^6)/16384 - ...
     (14549535*x.^4)/16384 + (2078505*x.^2)/65536 - 12155/65536;
phi{19}         = @(x) (4418157975*x.^19)/65536 - (20419054425*x.^17)/65536 + (9917826435*x.^15)/16384 - ...
     (10518906825*x.^13)/16384 + (13233463425*x.^11)/32768 - (5019589575*x.^9)/32768 + (557732175*x.^7)/16384 -...
     (66927861*x.^5)/16384 + (14549535*x.^3)/65536 - (230945.*x)/65536;
phi{20}         = @(x) (34461632205*x.^20)/262144 - (83945001525*x.^18)/131072 + (347123925225*x.^16)/262144 - ...
    (49589132175*x.^14)/32768 + (136745788725*x.^12)/131072 - (29113619535*x.^10)/65536 + (15058768725*x.^8)/131072 - ...
    (557732175*x.^6)/32768 + (334639305*x.^4)/262144 - (4849845*x.^2)/131072 + 46189/262144;

% Legendre polynomails are used after scaled with respect to the ub and lb
% values.
for i=1:n 
    for j=1:m 
         tt   = ub(i)-lb(i);
         y    = 2*(x(:,i)-ub(i))/(tt) + 1;
         PHI = sqrt(2*j+1)/sqrt(tt)*phi{j}(y);   
         A(:,(i-1)*m+j) = PHI;                  % Eq. (19)
    end
end

