function salinity = cond2sal(conductivity,temp)
% Converts conductivity to salinity using sw_c3515

CondRatio = conductivity./(sw_c3515.*1000);
press = zeros(size(CondRatio));
press = zeros(size(CondRatio));
sal = real(sw_salt(CondRatio(:),temp,press(:)));
salinity = sal;


end
function c3515 = sw_c3515()

% SW_C3515   Conductivity at (35,15,0)
%=========================================================================
% SW_c3515  $Revision: 1.1 $   $Date: 2007/02/14 04:50:07 $
%       %   Copyright (C) CSIRO, Phil Morgan 1993.
%
% USAGE:  c3515 = sw_c3515
%
% DESCRIPTION:
%   Returns conductivity at S=35 psu , T=15 C [ITPS 68] and P=0 db).
%
% INPUT: (none)
%
% OUTPUT:
%   c3515  = Conductivity   [mmho/cm == mS/cm]
%
% AUTHOR:  Phil Morgan 93-04-17  (morgan@ml.csiro.au)
%
% DISCLAIMER:
%   This software is provided "as is" without warranty of any kind.
%   See the file sw_copy.m for conditions of use and licence.
%
% REFERENCES:
%    R.C. Millard and K. Yang 1992.
%    "CTD Calibration and Processing Methods used by Woods Hole
%     Oceanographic Institution"  Draft April 14, 1992
%    (Personal communication)
%=========================================================================

% CALLER: none
% CALLEE: none
%

c3515 = 42.914;

return
%-------------------------------------------------------------------------
end
function S = sw_salt(cndr,T,P)

% SW_SALT    Salinity from cndr, T, P
%=========================================================================
% SW_SALT  $Revision: 1.1 $  $Date: 2007/02/14 04:50:07 $
%          Copyright (C) CSIRO, Phil Morgan 1993.
%
% USAGE: S = sw_salt(cndr,T,P)
%
% DESCRIPTION:
%   Calculates Salinity from conductivity ratio. UNESCO 1983 polynomial.
%
% INPUT:
%   cndr = Conductivity ratio     R =  C(S,T,P)/C(35,15,0) [no units]
%   T    = temperature [degree C (IPTS-68)]
%   P    = pressure    [db]
%
% OUTPUT:
%   S    = salinity    [psu      (PSS-78)]
%
% AUTHOR:  Phil Morgan 93-04-17  (morgan@ml.csiro.au)
%
% DISCLAIMER:
%   This software is provided "as is" without warranty of any kind.
%   See the file sw_copy.m for conditions of use and licence.
%
% REFERENCES:
%    Fofonoff, P. and Millard, R.C. Jr
%    Unesco 1983. Algorithms for computation of fundamental properties of
%    seawater, 1983. _Unesco Tech. Pap. in Mar. Sci._, No. 44, 53 pp.
%=========================================================================

% CALLER: general purpose
% CALLEE: sw_sals.m sw_salrt.m sw_salrp.m


%----------------------------------
% CHECK INPUTS ARE SAME DIMENSIONS
%----------------------------------
[mc,nc] = size(cndr);
[mt,nt] = size(T);
[mp,np] = size(P);

if ~(mc==mt | mc==mp | nc==nt | nc==np)
    error('sw_salt.m: cndr,T,P must all have the same dimensions')
end %if

%-------
% BEGIN
%-------
R  = cndr;
rt = sw_salrt(T);
Rp = sw_salrp(R,T,P);
Rt = R./(Rp.*rt);
S  = sw_sals(Rt,T);

return
%--------------------------------------------------------------------

end
function rt = sw_salrt(T)

% SW_SALRT   Conductivity ratio   rt(T)     = C(35,T,0)/C(35,15,0)
%=========================================================================
% SW_SALRT  $Revision: 1.1 $  $Date: 2007/02/14 04:50:07 $
%           Copyright (C) CSIRO, Phil Morgan 1993.
%
% USAGE:  rt = sw_salrt(T)
%
% DESCRIPTION:
%    Equation rt(T) = C(35,T,0)/C(35,15,0) used in calculating salinity.
%    UNESCO 1983 polynomial.
%
% INPUT:
%   T = temperature [degree C (IPTS-68)]
%
% OUTPUT:
%   rt = conductivity ratio  [no units]
%
% AUTHOR:  Phil Morgan 93-04-17  (morgan@ml.csiro.au)
%
% DISCLAIMER:
%   This software is provided "as is" without warranty of any kind.
%   See the file sw_copy.m for conditions of use and licence.
%
% REFERENCES:
%    Fofonoff, P. and Millard, R.C. Jr
%    Unesco 1983. Algorithms for computation of fundamental properties of
%    seawater, 1983. _Unesco Tech. Pap. in Mar. Sci._, No. 44, 53 pp.
%=========================================================================

% CALLER: sw_salt
% CALLEE: none

% rt = rt(T) = C(35,T,0)/C(35,15,0)
% Eqn (3) p.7 Unesco.

c0 =  0.6766097;
c1 =  2.00564e-2;
c2 =  1.104259e-4;
c3 = -6.9698e-7;
c4 =  1.0031e-9;

rt = c0 + (c1 + (c2 + (c3 + c4.*T).*T).*T).*T;

return
%--------------------------------------------------------------------
end
function Rp = sw_salrp(R,T,P)

% SW_SALRP   Conductivity ratio   Rp(S,T,P) = C(S,T,P)/C(S,T,0)
%=========================================================================
% SW_SALRP   $Revision: 1.1 $  $Date: 2007/02/14 04:50:07 $
%            Copyright (C) CSIRO, Phil Morgan 1993.
%
% USAGE:  Rp = sw_salrp(R,T,P)
%
% DESCRIPTION:
%    Equation Rp(S,T,P) = C(S,T,P)/C(S,T,0) used in calculating salinity.
%    UNESCO 1983 polynomial.
%
% INPUT: (All must have same shape)
%   R = Conductivity ratio  R =  C(S,T,P)/C(35,15,0) [no units]
%   T = temperature [degree C (IPTS-68)]
%   P = pressure    [db]
%
% OUTPUT:
%   Rp = conductivity ratio  Rp(S,T,P) = C(S,T,P)/C(S,T,0)  [no units]
%
% AUTHOR:  Phil Morgan 93-04-17  (morgan@ml.csiro.au)
%
% DISCLAIMER:
%   This software is provided "as is" without warranty of any kind.
%   See the file sw_copy.m for conditions of use and licence.
%
% REFERENCES:
%    Fofonoff, P. and Millard, R.C. Jr
%    Unesco 1983. Algorithms for computation of fundamental properties of
%    seawater, 1983. _Unesco Tech. Pap. in Mar. Sci._, No. 44, 53 pp.
%=========================================================================

% CALLER: sw_salt
% CALLEE: none

%-------------------
% CHECK INPUTS
%-------------------
if nargin~=3
    error('sw_salrp.m: requires 3 input arguments')
end %if

[mr,nr] = size(R);
[mp,np] = size(P);
[mt,nt] = size(T);
if ~(mr==mp | mr==mt | nr==np | nr==nt)
    error('sw_salrp.m: R,T,P must all have the same shape')
end %if

%-------------------
% eqn (4) p.8 unesco.
%-------------------
d1 =  3.426e-2;
d2 =  4.464e-4;
d3 =  4.215e-1;
d4 = -3.107e-3;

e1 =  2.070e-5;
e2 = -6.370e-10;
e3 =  3.989e-15;

Rp = 1 + ( P.*(e1 + e2.*P + e3.*P.^2) ) ...
    ./ (1 + d1.*T + d2.*T.^2 +(d3 + d4.*T).*R);

return
%-----------------------------------------------------------------------
end
function S = sw_sals(Rt,T)

% SW_SALS    Salinity of sea water
%=========================================================================
% SW_SALS  $Revision: 1.1 $  $Date: 2007/02/14 04:50:07 $
%          Copyright (C) CSIRO, Phil Morgan 1993.
%
% USAGE:  S = sw_sals(Rt,T)
%
% DESCRIPTION:
%    Salinity of sea water as a function of Rt and T.
%    UNESCO 1983 polynomial.
%
% INPUT:
%   Rt = Rt(S,T) = C(S,T,0)/C(35,T,0)
%   T  = temperature [degree C (IPTS-68)]
%
% OUTPUT:
%   S  = salinity    [psu      (PSS-78)]
%
% AUTHOR:  Phil Morgan 93-04-17  (morgan@ml.csiro.au)
%
% DISCLAIMER:
%   This software is provided "as is" without warranty of any kind.
%   See the file sw_copy.m for conditions of use and licence.
%
% REFERENCES:
%    Fofonoff, P. and Millard, R.C. Jr
%    Unesco 1983. Algorithms for computation of fundamental properties of
%    seawater, 1983. _Unesco Tech. Pap. in Mar. Sci._, No. 44, 53 pp.
%=========================================================================

% CALLER: sw_salt
% CALLEE: none

%--------------------------
% CHECK INPUTS
%--------------------------
if nargin~=2
    error('sw_sals.m: requires 2 input arguments')
end %if

[mrt,nrt] = size(Rt);
[mT,nT]   = size(T);
if ~(mrt==mT | nrt==nT)
    error('sw_sals.m: Rt and T must have the same shape')
end %if

%--------------------------
% eqn (1) & (2) p6,7 unesco
%--------------------------
a0 =  0.0080;
a1 = -0.1692;
a2 = 25.3851;
a3 = 14.0941;
a4 = -7.0261;
a5 =  2.7081;

b0 =  0.0005;
b1 = -0.0056;
b2 = -0.0066;
b3 = -0.0375;
b4 =  0.0636;
b5 = -0.0144;

k  =  0.0162;

Rtx   = sqrt(Rt);
del_T = T - 15;
del_S = (del_T ./ (1+k*del_T) ) .* ...
    ( b0 + (b1 + (b2+ (b3 + (b4 + b5.*Rtx).*Rtx).*Rtx).*Rtx).*Rtx);

S = a0 + (a1 + (a2 + (a3 + (a4 + a5.*Rtx).*Rtx).*Rtx).*Rtx).*Rtx;

S = S + del_S;

return
%----------------------------------------------------------------------
end