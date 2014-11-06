function currfig=figuretool1()  %#ok<*DEFNU,*DTXTRD,*AGROW>
tic; clearvars -global -except arglist frame paramlist camparam0 lighthdl;
global atomlist x y z defaultcolor aup bnorm cline unitcell CPfile CMfile MOfile mu3file xsffile res lightingstyle camparam lighthdl;

%%%---Figure parameters---%%%

camparam={'CV',[-0.1,0.8,0.06]};

%cameraset is used to control camera properties. Available parameters are 'PT','CP','CT','CV','CU','CR','CVA' and 'CZ'.
%PT(projectiontype): Can be 'orthographic' (default) or 'perspective'.
%CP(cameraposition), CT(cameratarget): Position and target of the camera (interdependent with CV).
%CV(viewingdirection): viewingdirection. Can be a 3-element array or a 2-element array [az,el]. Default is [0.8,0.3,0.1] unless both CP and CT are specified.
%   (In most cases it's sufficient to specify CV only and leave CP and CT as default.)
%CU(cameraup): updirection. Cannot be parallel to CV. Default is [0,0,1].
%CR(cameraroll): rotation of the camera around the viewing axis (in degrees). Performed after setting CU to updirection.
%CVA(cameraviewangle): viewing angle of the camera. Used for precise control of zooming.
%CZ(camerazoomfactor): zooming factor. Default is 1.
%Recommended settings: specify only CV, CU and CZ for ordinary figure making.

lightsource='default';                                   %Direction of lighting. Should be a 3-element array (light source position relative to the viewing direction)
                                                         %or a 2-element array [az,el], or 'default'.
lightingstyle='default';                                 %Lighting style of the objects. Could be 'default','chalk','china','glass','metal','plastic','rubber' or 'wax'.
res=10;                                                  %Resolution of the figure. 0=minimal resolution (fastest); 10 is usually good enough.
template='ScIr.prn';                                   %This file contains Cartesian/direct coordinates of the format 'La1 2.235 1.0 1.0' in each line.
                                                         %All dummy atoms should be labeled as 'Dummy0','Dummy1', etc.
                                                         %The 3 or 4 cell vectors should be labeled as '&' (optional but required for drawcell, etc.).
coordinatetype='Cartesian';                                 %Type of coordinates used in template file: can be 'direct' or 'Cartesian'.
cellconv='none';                                         %Conversion between conventional and primitive cells. Available options are 'f2p','p2f','i2p',
                                                         %'p2i','a2p','p2a','b2p','p2b','c2p','p2c','r2h','h2r', and 'none'.
defaultcolor={'Sc',[1,0,0.05];'Ga',[0,0.35,1]};         %Default color of each element/site ('name',[R G B]). Use semicolon to separate between elements.
                                                         %Color of a specific site overrides default color of that element.
connmap={'Cd','Cd',2,3;'Cd','Ca',2,3.5;'Ca','Ca',2,4};   %Default connectivity between elements ('elemname1','elemname2',dmin,dmax).
CPfile='CaCd2_o_CP.xsf';                                 %Filename of CP results. Only the -geo, -cell and -coeff files are needed.
CMfile='CaCd2_o_CM.xsf';                                 %Filename of CM results. Only the -geo, -cell and -coeff files are needed.
mu3file='Sc2Ir';                                         %Filename of mu3-acidity results. Only the .mu3output file is needed.
xsffile='LaNi2_o_CP.xsf-averaged.xsf';                   %Filename of .xsf file containing datagrid information.
MOfile='H2O.MO';                                         %Filename of .MO output file from YAeHMOP calculation.
printmode=0;                                             %Printing mode: 0 = display in a window, positive integer = display and print as png, negative
                                                         %integer = print as png without display, -1 = no display or printing (mainly for movie making).
                                                         %Resolution of png is equal to abs(printmode).
figurename='Sc57Ir13_unitcell';                          %Name of printed figure in .png format.

%%%---End of figure parameters---%%%

defaultinit(); makemovie=0; tmplread=true; if (nargin~=0)&&strcmpi(varargin{1}{1},'setdefault') tmplread=setdefault(varargin{1}); end
cameraset(camparam{:}); if isnumeric(lightsource)&&numel(lightsource)==2 [x1,y1,z1]=sph2cart(lightsource(1)/180*pi,lightsource(2)/180*pi,1); lightsource=[x1,y1,z1]; end
if (printmode<0)||(makemovie==-1) currfig=figure('visible','off'); if makemovie==0 disp('printmode<0. Figure not displayed.'); end, else currfig=figure; end
hold on; if tmplread [atomlist,x,y,z]=textread(template,'%s %f %f %f'); end, unitcell=convertcell(getcell(coordinatetype),cellconv); getunitcelllist();
atomdistinit(); elemgen(); preconnmap(connmap); bnorm=camarg('CV'); aup=camarg('CU'); cline=cross(aup,bnorm);
for k=1:nargin, if ~strcmpi(varargin{k}{1},'setdefault') fh=str2func(varargin{k}{1}); fh(varargin{k}{2:end}); end, end

%%%---Figure functions---%%%

drawatom('all');
drawbond('Sc');
drawbond('Ir');
drawcell('RN',[2,2,2],'BW',0.04);
drawinterface('unitcell&&Sc','unitcell&&Ir','RES',20,'SM','on','SMD',1,'RN',[-1,1,-1,1,-1,1],'FC',[0.3,0.6,1;0.8,0.8,0.3]);

%%%---End of figure functions---%%%

% ------- site selection: -------
% Many functions take input parameters labeled 'siteref', etc. which provide information about which atoms will be used in the function.
% A valid siteref expression has the form of one or more 'elements' connected by white spaces ' ' or double ampersands '&&'.
%
% Each element could take one of the following forms:
% a. A MATLAB numeric expression. Examples: '1' (the first atom in the template), '3:6' (atoms 3~6), '[4,6,8]' (atoms 4,6 and 8 in the template). 
%    Note: entries in an array must be separated by commas, not white spaces, e.g. '[4,6,8]' works, but '[4 6 8]' will produce an error.
% b. An element name or site name. Examples: 'La' (all La atoms in the template), 'Ni2' (all Ni2 atoms), 'Dummy' (all dummy atoms in the template).
%    Note: 1. When inserting dummy atoms, Diamond automatically labels them starting with 'Dummy', then 'Dummy1', 'Dummy2', etc. It might be helpful to
%             rename all 'Dummy' atoms to 'Dummy0' to avoid ambiguity as to whether 'Dummy' should refer to all dummy atoms or just the specific site.
%          2. You can use '&' to refer to the three cell vectors in template, but this is not recommended and will be disabled in figuretool2.
% c. 'all', which refers to all non-dummy, non-cell-vector atoms in template.
% d. 'used', which refers to all atoms that have been used in previous functions (so the order of functions becomes important).
% e. 'bonded', which refers to all atoms that are connected to any other atoms through bonds (drawbond/drawpoly/drawcoord; cell vectors do not count as
%    bonds). Make sure those bond-drawing functions are called before using this keyword.
% f. 'unitcell', which refers to all non-dummy, non-cell-vector atoms in the unit cell (range [-0.0001,0.9999,-0.0001,0.9999,-0.0001,0.9999]). Useful
%    for functions such as drawchannel, drawinterface, etc.
% 
% A white space ' ' connecting two elements takes their disjunction (union), e.g. 'La Ni2' specifies all La and all Ni2 atoms in the template.
% A double ampersand '&&' connecting two elements takes their conjunction (intersection), e.g. 'Ni && bonded' specifies all Ni atoms that are bonded to
%   any other atoms. '&&' HAS A HIGHER PRIORITY THAN ' ' (unfortunately parentheses are not supported in siteref expressions... yet).
% In addition, adding a minus sign '-' before an element rules out the specified atoms, e.g. '-La' specifies all non-La, non-dummy, and non-cell-vector
%   atoms in the template (equivalent to 'all -La'), 'Ni1 -used' specifies all unused Ni1 atoms. 
% -------------------------------

%drawatom: draws a set of ordinary atoms. Returns a list of atoms drawn.
%usage: sitelist=drawatom(siteref,[parampairs])
%siteref: specifies the atoms to be drawn.
%parampairs: available parameters are AC, R, AA, O, OC, and OW. (*DL *LP *FL *ACD *RES)
%AC(atomcolor)[='default'] specifies color of the atoms. Can be a 3-element array [R G B] or one of the following string specifiers: 'default','light',
%  'dark','verylight','verydark' or 'inverse', which uses the color specified in {defaultcolor} or default CPK color.
%R(radius)[='metallic 0.25'] specifies radii of the atoms. Can be a real number or a string: 'metallic' (metallic radii), 'atomic' (atomic radii),
%  'vdw' (Van der Waals radii), or a combination of both such as 'metallic 0.25' (0.25*metallic radius), etc.
%AA(atomalpha)[=1] specifies transparency of the atoms. 1=opaque and 0=totally transparent (invisible).
%O(outlineflag)[='off'] toggles outline 'on' or 'off', or 'dash' for a dashed outline.
%OC(outlinecolor)[='default'] specifies color of outline. Can be a 3-element array [R G B] or a string specifier.
%OW(outlinewidth)[=0.05] specifies width of outline.

%drawbond: draws a set of bonds within a set of atoms or between two sets of atoms. Returns only the bonded atoms.
%usage: sitelist=drawbond(siteref,[parampairs]) or sitelist=drawbond(siteref1,siteref2,[parampairs])
%parampairs: available parameters are RN, BT, BC, BW, BA, O, OC and OW. (*DL *FL *LP *RES *BS)
%RN(range)[='default'] specifies connectivity of the atoms. Can be a real number (dmax, where dmin=0), a 2-element array [dmin,dmax], or 'default', which
%  uses connectivities specified in {connmap} (default is [2,4] if not found).
%BT(bondtype)[='regular'] specifies type of the bond. Can be either 'regular', 'dash', 'double', 'triple' or 'quadruple'.
%BC(bondcolor)[='default' for regular bond; =[0,0,0] for dashed bond] specifies color of the bond. For regular bonds, it can be a 3-element array [R G B],
%  a 6-element array [R1 G1 B1 R2 G2 B2] which draws two-colored bonds, with [R1 G1 B1] to the end of siteref1 and [R2 G2 B2] to the end of siteref2 or
%  a string specifier, which draws two-colored bonds with the specified color. For dashed bonds, it can be a 3-element array [R G B] or a 6-element array
%  [R1 G1 B1 R2 G2 B2].
%BW(bondwidth)[=0.15] specifies width of the bond.
%BA(bondalpha)[=1] specifies transparency of the bond.

%drawcell: draws the unit cell (after cell conversion).
%usage: drawcell([parampairs])
%parampairs: available parameters are RN, OR, CT, BT, BC, BW, BA, O, OC and OW. (*DL *FL *RES)
%RN(range): specifies range of the unit cells to be drawn. Can be a 3-element array (number of cells to draw along x-,y- and z-axis), a 6-element array
%  [xmin,xmax,ymin,ymax,zmin,zmax], or 'unitcell' (only the cell [0,1]*[0,1]*[0,1]). If not specified, drawcell automatically determines the range
%  that best accommodates the atoms/bonds/polyhedra drawn in the figure so far.
%OR(origin)[=[0,0,0]]: specifies shift of the origin in direct/Cartesian coordinates (see CT). Should be a 3-element array.
%CT(coordinatetype)[='direct']: specifies if OR is interpreted as 'direct' or 'Cartesian' coordinates.
%BC(bondcolor)[=[0,0,0]].

%drawpoly: draws a polyhedron with the specified atoms as vertices. Returns the atoms on the convex hull (vertices of the polyhedron).
%usage: sitelist=drawpoly(siteref,[parampairs])
%parampairs: available parameters are FC, FA, DT, B, RN, BT, BC, BW, BA, O, OC and OW. (*FCD *FL *LP *BFL *BLP *DL *RES)
%FC(facecolor)[='default'] specifies color of the faces. Can be a 3-element array [R G B]. default color is a lighter shade of the average color of the
%  coordinating atoms.
%FA(facealpha)[=1] specifies transparency of the faces.
%DT(dihedraltolerance)[=1]. If two adjacent faces form a dihedral angle>180-dihedraltolerance, they are considered a single face and the bond between
%  them will not be drawn.
%B(bondflag)[='on'] toggles bonds 'on' or 'off'.
%BC(bondcolor)[='default']: default color is the average color of the coordinating atoms. 'bicolored' draws two-colored bonds.

%drawcoord: draws a set of polyhedra with each of the specified atoms as central atom. Returns atoms on each polyhedron and the central atoms.
%usage: sitelist=drawcoord(siteref,[parampairs])
%parampairs: available parameters are the same as drawpoly, plus CR and CS.
%CR(coordrange)[='default'] specifies connectivity used when determining the coordination polyhedra. Can be a single real number (dmax), a 2-element
%  array [dmin,dmax], or 'default' (as specified in {connmap}).
%CS(coordset)[='all'] specifies atoms considered when determining the coordination polyhedra. Can be an array or a string specifier.

%drawmu3: draws mu3 residual acidity spheres. Returns atoms of which RA spheres are drawn.
%usage: sitelist=drawmu3(siteref,scale,[parampairs])
%parampairs: available parameters are AA, O, OC and OW. (*RES)
%O(outlineflag)[='on'].

%drawCP: draws CP lobes. Returns atoms of which CP lobes are drawn.
%usage: sitelist=drawCP(siteref,scale,[parampairs])
%parampairs: available parameters are M, O, OC, OW, LM, LA and LC. (*FL *LP *RES)
%M(mode)[='CP'] specifies the mode for drawing CP lobes. 'CP'=draws only CP lobes; 'CM'=draws only CM lobes; 'both'=draws both CP and CM lobes;
%  'mixed' draws CP lobes with color based on CM data. in 'both' mode, scale and LA should be a 2-element array; in 'both' and 'mixed' mode, LC can
%  be a 2-by-6 matrix, with the 1st and 2nd row corresponding to CP and CM colors, respectively.
%LM(lmax)[=99] specifies the maximum angular momentum to be drawn.
%LA(lobealpha)[=1] specifies transparency of the lobe. In 'both' mode, default is [1,0.25].
%LC(lobecolor)[='default'] specifies color of the lobes. Can be a 6-element array [Rp Gp Bp Rn Gn Bn] or 'colored', which uses 'verylight' for positive
%  and 'verydark' for negative lobes. If not specified, [0.8,0.8,0.8] is used for positive and [0,0,0] is used for negative lobes. In 'both' and 'mixed'
%  mode, the default color is [0.8,0.8,0.8,0,0,0;1,0,0,0,0,1].

%drawraMO: draws raMO lobes. This is an interface function and is intended to be called from makeramo.m, so don't call it within figuretool.

%drawxsf: draws isosurface from a .xsf file.
%usage: drawxsf(isolevel,[parampairs])
%isolevel: can be a single real number or a 2-element array [isomin,isomax].
%parampairs: available parameters are RN, FC, FA and SM. (*FL *LP *SMS *SMD *SEC *SECC *SECA)
%RN(range)[=[0,1,0,1,0,1]]: specifies range (in direct coordinates) of the xsf file to be drawn. Could be a 6-element array [xmin,xmax,ymin,ymax,zmin,zmax],
%  or a cell array {centralatom,[rangex,rangey,rangez]}.
%SM(smoothflag)[='off']: toggles smoothing of the surface 'on' or 'off'.

%drawchannel: draws channel surfaces in the unit cell (make sure you have all the atoms in the template file).
%usage: drawchannel([parampairs])
%parampairs: available parameters are R, RN, FC, FA and SM. (*FL *LP *SMS *SMD *RES)
%R(radius)[='vdw']: specifies radius of the atoms used for surface calculation.
%RN(range)[=[0,1,0,1,0,1]]: specifies range (in direct coordinates) of the surface to be drawn. Could be a 6-element array [xmin,xmax,ymin,ymax,zmin,zmax],
%  or a cell array {centralatom,[rangex,rangey,rangez]}.
%SM(smoothflag)[='off']: toggles smoothing of the surface 'on' or 'off'.

%drawinterface: draws interface between two sets of atoms in the unit cell.
%usage: drawinterface(siteref1,siteref2,[parampairs])
%parampairs: available parameters are EXP, R, RN, FC, FA and SM. (*FL *LP *SMS *SMD *RES)
%EXP(cexp)[=2.5]: exponential factor used in interface determination. Larger exp gives more 'polyhedral-ish' interface.
%  Could be a positive real number or a two-element array [exp1,exp2], corresponding to the two atom sets. (The interface will be closer to the atom set with
%  larger exp.)
%FC(facecolor)[=[0.5,0.5,0.5]]: could be a 3-element vector or a 2-by-3 matrix. In the latter case, the interface drawn has different colors on its two sides:
%  the first row of FC specifies the color of the side facing towards siteref1, the second row facing towards siteref2.
%R(radius)[=6]: specifies the range of the atoms considered in interface determination.
%RN(range)[=[0,1,0,1,0,1]]: specifies range (in direct coordinates) of the surface to be drawn. Could be a 6-element array [xmin,xmax,ymin,ymax,zmin,zmax],
%  or a cell array {centralatom,[rangex,rangey,rangez]}.
%SM(smoothflag)[='off']: toggles smoothing of the surface 'on' or 'off'.

%drawsurface: draws an arbitrary isosurface.
%usage: drawsurface(funchdl,isovalue,[parampairs])
%funchdl: handle of the isosurface function. Should allow 3 matrix arguments.
%isovalue: isovalue for the isosurface. Should be a real number.
%parampairs: available parameters are RN, CT, FA, FC and SM. (*FL *LP *RES *FCR *FCM *SMS *SMD)
%RN(range)[=[0,1,0,1,0,1]]: specifies range of the isosurface. Should be a 6-element array [xmin,xmax,ymin,ymax,zmin,zmax].
%CT(coordtype)[='direct']: determines whether RN is interpreted as 'direct' or 'Cartesian' coordinates.
%FC(facecolor)[=[0.5,0.5,0.5]]: color of the isosurface. Could be a 3-element array [R,G,B] or 'xsf', in which case xsf data is used for coloring.
%SM(smoothflag)[='off']: toggles smoothing of the surface 'on' or 'off'.
%  ('xsf' option is also supported in drawmiller and drawplane.)

%drawmiller: draws miller planes.
%usage: drawmiller(hkl,type,dist0,[parampairs])
%hkl: Miller index of the plane. Should be a 3-element array.
%type: indicates how dist0 specifies position of the plane. Could be 'direct'/'Cartesian' (direct/Cartesian coordinate of a point on the plane), 'atom'
%  (numbering of an atom sitting on the plane), 'distr' (distance of the plane from origin), or 'distc' (fractional distance of the plane from origin).
%parampairs: available parameters are RN, FA and FC. (*LP)

%drawplane: draws plane through three atoms or points.
%usage: drawplane(coord,coordtype,[parampairs])
%coord: coordinates of the three points. If coordtype='atom', coord should be a 3-element array of the 3-atoms; if coordtype='Cartesian'/'direct', coord
%  should be a 3-by-3 matrix, with each row containing the Cartesian/direct coordinates of one point.
%parampairs: available parameters are RN, FA and FC. (*LP)

%drawMO: draws LCAO-type molecular orbital.
%usage: drawMO(aolist,isovalue,[parampairs])
%aolist: A cell array of atomic orbital information. Each row should have the form {5 (number of the central atom),'px' (type of orbital),2.5 (scale)}.
%  Available orbitals are 's','px','py','pz','dx2-y2','dz2','dxy','dxz','dyz','fx3','fy3','fz3','fx(z2-y2)','fy(z2-x2)','fz(x2-y2)','fxyz','fxz2',
%  'fyz2','fy(3x2-y2)' and 'fx(x2-3y2)'. Can also be a number corresponding to the MO in a YAeHMOP .MO output file.
%isovalue: isovalue of the MO isosurface.
%parampairs: available parameters are CS, D, LA and LC. (*FL *LP *RES)
%CS(coordsystem)[='cell'] specifies orientation of the coordinate system used to define the atomic orbitals. Could be a 3-by-3 orthogonal matrix, or
%  one of the following strings: 'cell', 'view' or 'fit'. 'cell' uses orthogonalized cell vectors; 'view' sets current viewing axes as the coordinate
%  system; 'fit' uses the best fit plane as coordinate system for MO on more than 3 atoms.
%D(dist)[=2]: specifies range of the isosurface area (you may need to increase it if part of the lobe is missing).
%LC(lobecolor)[='default']: specifies color of the lobes. Could be a 6-element array [Rp,Gp,Bp,Rn,Gn,Bn] or 'default' or 'colored'. 'default' uses
%  [0.8,0.8,0.8] for positive and [0,0,0] for negative lobes; 'colored' uses average of 'verylight' and 'verydark' colors of the atoms.

%drawgreenline: draws a green line for size comparison between different figures. It is drawn at the bottom of the figure.
%usage: drawgreenline([parampairs])
%D(dist)[=1]: distance from the green line to the figure. In some cases (e.g. very large CP lobes) it might be necessary to increase it.

%drawboundbox: draws a rectangular bound box around the figure, mainly for photoshop purposes.
%usage: drawboundbox([parampairs])
%D(dist)[=1]: distance of each edge of the bound box from figure.
%IB(imagebound)[=imgbound].

%drawcoordsystem: draws a coordinate system of cell vectors (need to be specified as '&' in template file).
%usage: drawcoordsystem([parampairs])
%D(dist)[=1.5]: distance of the coordinate system from the figure.
%T(textflag)[='on']: toggles the labels on the axes ('a','b' and 'c') 'on' or 'off'.
%SC(scale)[=1]: specifies size of the coordinate system.

%insertfigure: inserts a rectangular graphic file into the figure.
%usage: insertfigure(filename,postype,figpos,[parampairs])
%filename: full name of the graphic file. Most common formats are supported.
%postype: indicates how figpos specifies position of the figure. Could be 'Cartesian'/'direct' (figpos should be a 4-by-3 matrix [xi,yi,zi] of Cartesian/
%  direct coordinates), 'atom' (figpos should be a 4-element array of four atoms), or 'centerat' (figpos should be a cell array {center,xvector,yvector}
%  where center=[xc,yc,zc] is the center of the figure, and xvector/yvector specifies orientation of the figure).
%Available parameters are FA. (*FL *LP)
%FA: transparency of the figure.

%bottomtext: displays text below the figure.
%usage: bottomtext(strarray,[parampairs])
%strarray     : the text to be displayed.
%D(dist)[=1]: distance of the text to the bottom of the figure.
%TFS(textfontsize)[=10]: font size of the text.
%TFN(textfontname)[='Helvetica']: name of the font used.
%TFC(textfontcolor)[=[0,0,0]]: color of the text.

%Auxiliary functions:

%coord: Returns all atom sites within a coordination range of an atom set .
%usage: coordset=coord(atomsetref,[rangeref='default'],[instring='all'])
%coord returns all atom sites that lies within a coordination range of atomsetref specified by rangeref (i.e. an atom with a distance larger than dmin
%to all atoms in atomsetref and a distance smaller than dmax to at least one atom in atomsetref).
%atomsetref   : can be an array or a string specifier.
%rangeref     : can be a two-element array [dmin dmax], or a positive real number (dmax, while dmin is set to 0), or 'default' in which case ranges
%               specified in {connmap} are used.
%instring     : restricts the returned atom set to a specific type of atoms. For example, if instring='La', only the La atoms in the coordination range
%               are selected.

%getmol: Returns molecules starting from a given set of atoms with specified connectivity.
%usage: sitelist=getmol(startref,instring,[rangeref='default'])
%startref     : the atoms to begin with for the molecule search. Can be either an array or a string specifier.
%instring     : the atoms/sites to be included in the molecules. Can be either an array or a string specifier.
%rangeref     : connectivity used for the searching process. Can be a two-element array [dmin,dmax], a single real number (dmax) or 'default', in which
%               case {connmap} will be used.

%rngselect: Returns atoms in a certain range.
%usage: sitelist=rngselect(rngtype,rngref,[siteref='all'])
%rngtype      : specifies the type of range used. Can be 'sphere','box' or 'slab'.
%siteref      : specifies atom sites to include in the returned list.
%rngtype='sphere': rngref={center,RCflag,range}. center can be a single integer (number of atom in atomlist) or a [x,y,z] coordinate. RCflag can be
%                  either 'Cartesian' or 'direct' if [x,y,z] coordinate is used for center. range specifies the (Cartesian) radius of the sphere.
%rngtype='box'   : rngref={center,RCflag,range}. center/RCflag are the same as above. range can be either a real number (a cube with edge length=2*range
%                  centered at center) or an array [xr,yr,zr] (a cuboid of size 2*xr by 2*yr by 2*zr centered at center).
%rngtype='slab'  : rngref={points,RCflag,range}. RCflag is the same as above. points can be a 3-element array (3 atoms in atomlist) or a 3-by-3 matrix
%                  [x1,y1,z1;x2,y2,z2;x3,y3,z3] to specify position of the plane. range specifies the thickness of the slab (=2*range).

axis off; axis equal; set(gca,'CameraViewAngleMode','manual'); set(gcf,'color',[1 1 1]);
if ischar(lightsource) lightsource=[0.5696,1.0959,0.4397]*[bnorm;cline;aup]; else lightsource=lightsource*[bnorm;cline;aup]; end
objnum=objstat(); setcamera(); lighthdl=light('position',lightsource); colordepth0(); fadealpha0();
if makemovie==0
   disp(['Objects drawn: ',num2str(objnum(1)),' atoms, ',num2str(objnum(2)),' lobes, ',num2str(objnum(3)),' bonds, ',num2str(objnum(4)),' polyhedra, ',num2str(objnum(5)),' surfaces']);
   disp(['Rendering time: ',num2str(toc),' seconds']);
end
if (printmode~=0)&&(printmode~=-1) print(currfig,[figurename,'.png'],'-dpng',['-r',num2str(abs(printmode))]); end
if makemovie==-1 currfig={'template',template,'defaultcolor',defaultcolor,'connmap',connmap,'lightsource',lightsource,'updirection',camarg('RA')}; return; end

function tmplread=setdefault(cellin)
tmplread=true;
for k=2:2:numel(cellin)
   if ismember(cellin{k},{'template','lightsource','res','coordinatetype','x','y','z','unitcell','camparam','atomlist','cellconv','CPfile',...
         'CMfile','mu3file','xsffile','MOfile','lightingstyle','defaultcolor','connmap','makemovie','printmode','figurename'})
      assignin('caller',cellin{k},cellin{k+1});
   end
end
if all(ismember({'x','y','z','atomlist'},cellin(2:2:numel(cellin)))) tmplread=false; end

function setfuncdefault(cellin,paramuse)
abbrlist={'AC','atomcolor';'R','radius';'AA','atomalpha';'O','OLflag';'OC','OLcolor';'OW','OLwidth';'RN','range';'BC','bondcolor';'LA','lobealpha';...
   'BT','bondtype';'BW','bondwidth';'BA','bondalpha';'FC','facecolor';'FA','facealpha';'FL','facelighting';'DT','dihedraltol';'B','bondflag';...
   'CS','coordset';'CR','coordrange';'LC','lobecolor';'LM','lmax';'FCD','facecdata';'DL','dashlength';'LP','lightparam';'BLP','BLP';'BFL','BFL';...
   'OR','origin';'CT','coordtype';'AM','noninuse';'AF','noninuse';'IS','noninuse';'D','dist';'T','textflag';'IB','bounduse';'TFS','fontsize';...
   'TFN','fontname';'TFC','fontcolor';'M','mode';'SC','scale';'ACD','atomcolordata';'RES','resuse';'SM','smoothflag';'SMS','smoothsize';'EXP','cexp';...
   'SMD','smoothdev';'SEC','sectionflag';'SECC','sectioncolor';'SECA','sectionalpha';'FCR','facecolorrange';'FCM','facecolormap';'BS','bondsep'};
for k=1:2:numel(cellin)
   [~,loc]=ismember(cellin{k},abbrlist);[~,loc2]=ismember(cellin{k},paramuse);
   if (loc~=0)&&(loc2~=0) cellin{k}=abbrlist{rem(loc-1,size(abbrlist,1))+1,2}; assignin('caller',cellin{k},cellin{k+1});
   else error(['Unrecognized property name/identifier ''',cellin{k},'''.']);
   end
end

function setcamdefault(cellin)
for k=1:2:numel(cellin)
   if ismember(cellin{k},{'PT','CP','CT','CV','CU','CR','CZ','CVA'}) assignin('caller',cellin{k},cellin{k+1});
   else error(['Unrecognized property name/identifier ''',cellin{k},'''.']);
   end
end

function cameraset(varargin)
global camparam;
PT='orthographic';CP='default';CT='default';CV='default';CU=[0,0,1];CR=0;CZ=1;CVA='default'; setcamdefault(varargin);
if isnumeric(CV)&&(numel(CV)==2) [xx,yy,zz]=sph2cart(CV(1)*pi/180,CV(2)*pi/180,1); CV=[xx,yy,zz]; end
if isnumeric(CP)&&isnumeric(CT)
   seg=CP-CT; if isnumeric(CV)&&((norm(cross(seg,CV))>0.00001)||(dot(seg,CV)<0)) error('Incompatible CP, CT and CV.'); end
   CV=seg;
elseif ~isnumeric(CV) CV=[0.8,0.3,0.1];
end
CV=CV/norm(CV); CU=CU/norm(CU);
if norm(cross(CV,CU))<0.00001 error('up direction cannot be parallel to viewing direction.');
else CU0=CU-dot(CU,CV)*CV; CU0=CU0/norm(CU0);
end
if CR~=0 CW=cross(CV,CU0);CW=CW/norm(CW);CU0=cos(CR/180*pi)*CU0+sin(CR/180*pi)*CW;CR=0; end
camparam={'PT',PT;'CP',CP;'CT',CT;'CV',CV;'CU',CU0;'RA',CU;'CR',CR;'CZ',CZ;'CVA',CVA};

function camargout=camarg(instring,value)
global camparam;
[~,loc]=ismember(instring,camparam(:,1)); if loc==0 error(['Unrecognized camera property name ''',instring,'''.']); end
if nargin==2 camparam{loc,2}=value; end
camargout=camparam{loc,2};

function setcamera()
PT=camarg('PT');CT=camarg('CT');CP=camarg('CP');CV=camarg('CV');CU=camarg('CU');CR=camarg('CR');CVA=camarg('CVA');CZ=camarg('CZ');
camproj(PT);
t1=isnumeric(CP);t2=isnumeric(CT);
if (~t1)&&(~t2) view(CV);
elseif (~t1)&&(t2) view(CV); campos(campos-camtarget+CT);camtarget(CT);
elseif (t1)&&(~t2) view(CV); camtarget(camtarget-campos+CP);campos(CP);
else camtarget(CT);campos(CP);
end
camup(CU);camroll(CR);
if isnumeric(CVA) camva(CVA); end
camzoom(CZ);

function getunitcelllist()
global atomlist x y z unitcell unitcelllist;
temp=[x,y,z]/unitcell;
unitcelllist=find((temp(:,1)>-0.0001)&(temp(:,1)<0.9999)&(temp(:,2)>-0.0001)&(temp(:,2)<0.9999)&(temp(:,3)>-0.0001)&(temp(:,3)<0.9999)&~strcmp('&',atomlist));

function unitcell=getcell(coordinatetype)
global atomlist x y z;
if sum(strcmpi('&',atomlist))==3 unitcell=[x(strcmp('&',atomlist)),y(strcmp('&',atomlist)),z(strcmp('&',atomlist))];
elseif sum(strcmpi('&',atomlist))==4
   temp=[x(strcmp('&',atomlist)),y(strcmp('&',atomlist)),z(strcmp('&',atomlist))];
   unitcell=temp(2:4,:)-repmat(temp(1,:),3,1);
else unitcell=zeros(3);
end
if strcmpi(coordinatetype,'direct')
   temp=[x,y,z]*unitcell; temp=temp(~strcmp('&',atomlist),:);
   x(~strcmp('&',atomlist))=temp(:,1);y(~strcmp('&',atomlist))=temp(:,2);z(~strcmp('&',atomlist))=temp(:,3);
end

function defaultinit()
global elemname CPKcolor metalrad atomrad vdwrad imgbound cellbound atomused bondlist objlist xsfgrid MOdata faderadius depthcueing;
elemname={'&','Dummy','H','He','Li','Be','B','C','N','O','F','Ne','Na','Mg','Al','Si','P','S','Cl','Ar','K','Ca',...
   'Sc','Ti','V','Cr','Mn','Fe','Co','Ni','Cu','Zn','Ga','Ge','As','Se','Br','Kr','Rb','Sr','Y','Zr','Nb','Mo',...
   'Tc','Ru','Rh','Pd','Ag','Cd','In','Sn','Sb','Te','I','Xe','Cs','Ba','La','Ce','Pr','Nd','Pm','Sm','Eu','Gd',...
   'Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Ta','W','Re','Os','Ir','Pt','Au','Hg','Tl','Pb','Bi','Po'};
CPKcolor={[0 0 0],[0 0 0],[255 255 255],[217 255 255],[204 128 255],[194 255 0],[255 181 181],[144 144 144],[48 80 248],...
   [255 13 13],[144 224 80],[179 227 245],[171 92 242],[138 255 0],[191 166 166],[240 200 160],[255 128 0],[255 255 48],...
   [31 240 31],[128 209 227],[143 64 212],[61 255 0],[230 230 230],[191 194 199],[166 166 171],[138 153 199],[156 122 199],...
   [224 102 51],[240 144 160],[80 208 80],[200 128 51],[125 128 176],[194 143 143],[102 143 143],[189 128 227],[255 161 0],...
   [166 41 41],[92 184 209],[112 46 176],[0 255 0],[148 255 255],[148 224 224],[115 194 201],[84 181 181],[59 158 158],...
   [36 143 143],[10 125 140],[0 105 133],[192 192 192],[255 217 143],[166 117 115],[102 128 128],[158 99 181],[212 122 0],...
   [148 0 148],[66 158 176],[87 23 143],[0 201 0],[112 212 255],[255 255 199],[217 255 199],[199 255 199],[163 255 199],...
   [143 255 199],[97 255 199],[69 255 199],[48 255 199],[31 255 199],[0 255 156],[0 230 117],[0 212 82],[0 191 56],[0 171 36],...
   [77 194 255],[77 166 255],[33 148 214],[38 125 171],[38 102 150],[23 84 135],[208 208 224],[255 209 35],[184 184 208],...
   [166 84 77],[87 89 97],[158 79 181],[171 92 0]};
metalrad=[0.5,1.0,0.75,1.0,1.52,1.12,1.0,1.0,1.0,1.0,1.0,1.0,1.86,1.6,1.43,1.0,1.0,1.0,1.0,1.0,2.27,1.97,1.62,1.47,1.34,1.28,1.27,1.26,1.25,1.24,...
   1.28,1.34,1.35,1.0,1.0,1.4,1.0,1.0,2.48,2.15,1.8,1.6,1.46,1.39,1.36,1.34,1.34,1.37,1.44,1.51,1.67,1.0,1.0,1.6,1.0,1.0,2.65,2.22,1.87,1.818,...
   1.824,1.814,1.834,1.804,2.084,1.804,1.773,1.781,1.762,1.761,1.759,1.933,1.738,1.59,1.46,1.39,1.37,1.35,1.355,1.385,1.44,1.51,1.7,1.0,1.0,1.68];
atomrad=[0.5,1.0,0.25,0.31,1.45,1.05,0.85,0.7,0.65,0.6,0.5,0.38,1.8,1.5,1.25,1.1,1,1,1,0.71,2.2,1.8,1.6,1.4,1.35,1.4,1.4,1.4,1.35,1.35,1.35,1.35,...
   1.3,1.25,1.15,1.15,1.15,0.88,2.35,2,1.8,1.55,1.45,1.45,1.35,1.3,1.35,1.4,1.6,1.55,1.55,1.45,1.45,1.4,1.4,1.08,2.6,2.15,1.95,1.85,1.85,1.85,...
   1.85,1.85,1.85,1.8,1.75,1.75,1.75,1.75,1.75,1.75,1.75,1.55,1.45,1.35,1.35,1.3,1.35,1.35,1.35,1.5,1.9,1.8,1.6,1.9];
vdwrad=[0.0,0.0,1.10,1.40,1.81,1.53,1.92,1.70,1.55,1.52,1.47,1.54,2.27,1.73,1.84,2.10,1.80,1.80,1.75,1.88,2.75,2.31,2.28,2.14,2.03,1.97,1.96,1.96,...
   1.95,1.94,2.00,2.02,1.87,2.11,1.85,1.90,1.83,2.02,3.03,2.49,2.45,2.25,2.13,2.06,2.04,2.02,2.02,2.05,2.13,2.17,1.93,2.17,2.06,2.06,1.98,2.16,3.43,...
   2.68,2.51,2.47,2.44,2.41,2.38,2.35,2.32,2.30,2.28,2.26,2.24,2.22,2.21,2.21,2.22,2.24,2.13,2.07,2.05,2.03,2.03,2.06,2.13,2.17,1.96,2.02,2.07,1.97];
imgbound=[1000,1000,1000,-1000,-1000,-1000];
cellbound=[1000,1000,1000,-1000,-1000,-1000];
atomused=[];bondlist=[];xsfgrid=[];faderadius=[];depthcueing=[];objlist={};MOdata=[];

function boundout=imagebound(boundin)
global imgbound;
if nargin==0 boundout=imgbound;
else imgbound=boundin; boundout=boundin;
end

function outcell=convertcell(incell,convstr)
switch convstr
   case 'none', convmatrix=[1,0,0;0,1,0;0,0,1];
   case 'f2p', convmatrix=[0,0.5,0.5;0.5,0,0.5;0.5,0.5,0];
   case 'p2f', convmatrix=[-1,1,1;1,-1,1;1,1,-1];
   case 'i2p', convmatrix=[-0.5,0.5,0.5;0.5,-0.5,0.5;0.5,0.5,-0.5];
   case 'p2i', convmatrix=[0,1,1;1,0,1;1,1,0];
   case 'a2p', convmatrix=[1,0,0;0,0.5,0.5;0,-0.5,0.5];
   case 'p2a', convmatrix=[1,0,0;0,1,-1;0,1,1];
   case 'b2p', convmatrix=[0.5,0,0.5;0,1,0;-0.5,0,0.5];
   case 'p2b', convmatrix=[1,0,-1;0,1,0;1,0,1];
   case 'c2p', convmatrix=[0.5,0.5,0;-0.5,0.5,0;0,0,1];
   case 'p2c', convmatrix=[1,-1,0;1,1,0;0,0,1];
   case 'r2h', convmatrix=[1,-1,0;0,1,-1;1,1,1];
   case 'h2r', convmatrix=[2,1,1;-1,1,1;-1,-2,1]/3;
   otherwise error(['Unrecognized cell conversion''',convstr,'''!']);
end
outcell=convmatrix*incell;

function atomdistinit()
global x y z;
global atomdist;
dx=reshape([x,y,z],[numel(x),1,3]);
atomdist=sum(bsxfun(@minus,dx,permute(dx,[2,1,3])).^2,3).^0.5;

function angout=dihedral(i,j,k,l)
global x y z;
ic=[x(i) y(i) z(i)];
jc=[x(j) y(j) z(j)];
kc=[x(k) y(k) z(k)];
lc=[x(l) y(l) z(l)];
norm1=cross(jc-ic,kc-jc);
norm2=cross(ic-jc,lc-ic);
angout=acos(dot(norm1,norm2)/(norm(norm1)*norm(norm2)));

function dist=d2plane(ir,points)
global x y z;
dist=zeros(numel(ir),1);
p0=[x(ir),y(ir),z(ir)];
p1=points(1,:);
p2=points(2,:);
p3=points(3,:);
for i=1:numel(ir)
   dist(i)=abs(det([p1-p0(i,:);p2-p0(i,:);p3-p0(i,:)]));
end
dist=dist/norm(cross(p3-p1,p2-p1));

function vnorm=fitsuperplane(xyzlist)
global x y z;
if size(xyzlist,2)==1 xyzlist=[x(xyzlist),y(xyzlist),z(xyzlist)]; end
reduced=xyzlist-repmat(mean(xyzlist,1),size(xyzlist,1),1);
[vnorm,~]=eig(reduced'*reduced);
vnorm=vnorm(:,1)';

function infostring=atominfo(i)
global atomlist x y z;
infostring=['atom ',num2str(i),': ',atomlist{i},' (',num2str(x(i)),',',num2str(y(i)),',',num2str(z(i)),')'];

function bottomtext(varargin)
global aup bnorm cline;
global imgbound;
paramuse={'D','TFS','TFN','TFC'};
strarray=varargin{1}; fontname='Helvetica'; fontsize=10; dist=1; fontcolor=[0,0,0]; setfuncdefault(varargin(2:end),paramuse);
point0=[imgbound(1)-dist 0 0.5*(imgbound(3)+imgbound(6))]*[aup;bnorm;cline];
text(point0(1),point0(2),point0(3),strarray,'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',fontsize,'FontName',fontname,'Color',fontcolor);
boundupdatex(point0);

function objnum=objstat()
global objlist;
objnum=[0,0,0,0,0];
for k=1:size(objlist,1)
   if ismember(objlist{k,2},{'atom','mu3'}) objnum(1)=objnum(1)+1;
   elseif strcmp(objlist{k,2},'lobe') objnum(2)=objnum(2)+1;
   elseif strcmp(objlist{k,2},'poly') objnum(4)=objnum(4)+1;
   elseif strcmp(objlist{k,2},'surf') objnum(5)=objnum(5)+1;
   else objnum(3)=objnum(3)+1;
   end
end

function atomupdate(sitelist)
global x y z;
global atomused;
atomused=unique([atomused,sitelist]);
points=[x(sitelist') y(sitelist') z(sitelist')];
boundupdatex(points);

function boundupdatex(points)
global aup bnorm cline;
global imgbound cellbound;
if isempty(points) return; end
cellbound(1:3)=min([cellbound(1:3);points]);
cellbound(4:6)=max([cellbound(4:6);points]);
pointsc=points/[aup;bnorm;cline];
imgbound(1:3)=min([imgbound(1:3);pointsc]);
imgbound(4:6)=max([imgbound(4:6);pointsc]);

function outcolor=atomcolorlookup(instring,i)
global defaultcolor;
global elemname CPKcolor;
global atomlist;
persistent warned1 warned2;
if isempty(warned1) warned1=false; warned2=false; end
outcolor=zeros(numel(i),3);
for k=1:numel(i)
   if isnumeric(i) str=atomlist{i(k)}; elseif iscell(i) str=i{k}; end
   loc=0;
   if ~ischar(instring)
      outcolor(k,:)=instring;
      continue;
   end
   if size(defaultcolor,1)~=0
      [~,loc]=ismember(str,defaultcolor(:,1));
      if loc~=0 defcolor=defaultcolor{loc,2};
      else
         [~,loc]=ismember(getelem(str),defaultcolor(:,1));
         if loc~=0 defcolor=defaultcolor{loc,2}; end
      end
   end
   if loc==0
      [~,loc]=ismember(getelem(str),elemname);
      if loc~=0 defcolor=CPKcolor{loc}/255;
      else
         if warned1==false warning('Figuretool:defaultnotfound',['Default CPK color not found for atom ''',getelem(i),'''. Black color is used.']); warned1=true; end
      end
   end
   if strcmpi(instring,'default') outcolor(k,:)=defcolor;
   elseif strcmpi(instring,'light') outcolor(k,:)=[0.5 0.5 0.5]+0.5*defcolor;
   elseif strcmpi(instring,'verylight') outcolor(k,:)=[0.75 0.75 0.75]+0.25*defcolor;
   elseif strcmpi(instring,'dark') outcolor(k,:)=0.25*defcolor;
   elseif strcmpi(instring,'verydark') outcolor(k,:)=0.1*defcolor;
   elseif strcmpi(instring,'inverse') outcolor(k,:)=[1 1 1]-defcolor;
   else
      outcolor(k,:)=[0 0 0];
      if warned2==false warning('Figuretool:defaultnotfound',['Unrecognized color specifier ''',instring,'''. Black color is used.']); warned2=true; end
   end
end

function outcolor=bondcolorlookup(instring,i,j)
persistent warned;
if isempty(warned) warned=false; end
if ~ischar(instring)
   outcolor=instring;
else
   if ismember(instring,{'default','light','dark','verylight','verydark','inverse'}) outcolor=[atomcolorlookup(instring,i),atomcolorlookup(instring,j)];
   else
      outcolor=[0 0 0];
      if warned==false warning('Figuretool:defaultnotfound',['Unrecognized bond color specifier ''',instring,'''. Black color is used.']); warned=true; end
   end
end

function lpout=getlightparam(lpin,defaultparam)
global lightingstyle;
if ~strcmpi(lightingstyle,'default')&&strcmpi(lpin,'default') lpin=lightingstyle; end
if ~ischar(lpin) lpout=lpin;
else
   switch lpin
      case 'chalk', lpout=[0.25,0.75,0,1];
      case 'china', lpout=[0.25,0.75,1,30];
      case 'glass', lpout=[0.5,0,1,20];
      case 'metal', lpout=[0.5,0.1,0.9,1];
      case 'plastic', lpout=[0.75,0.75,1,9];
      case 'rubber', lpout=[0.75,0.75,0,1];
      case 'wax', lpout=[0.2,1,0.5,10];
      case 'default', lpout=defaultparam;
      otherwise error(['Unrecognized lighting style''',lpin,'''!']);
   end
end

function radout=atomradiuslookup(instring,i)
global elemname;
global metalrad atomrad vdwrad;
radout=zeros(1,numel(i));
for k=1:numel(i)
   if ~ischar(instring) radout(k)=instring; continue;
   end
   strarray=regexp(instring,' ','split');
   if size(strarray,2)==2 nscale=str2double(strarray{2});
   else nscale=1;
   end
   [~,loc]=ismember(getelem(i(k)),elemname);
   if loc==0 radout(k)=0.5;
   elseif strcmpi(strarray{1},'metallic') radout(k)=nscale*metalrad(loc);
   elseif strcmpi(strarray{1},'atomic') radout(k)=nscale*atomrad(loc);
   elseif strcmpi(strarray{1},'vdw') radout(k)=nscale*vdwrad(loc);
   end
end

function elemgen()
global atomlist elemlist;
elemlist=cell(size(atomlist));
for i=1:numel(atomlist)
   elemlist{i}=getelem(atomlist{i});
end

function elementname=getelem(instring)
global elemlist;
if isnumeric(instring)
   if numel(instring)==1 elementname=elemlist{instring};
   else elementname=elemlist(instring);
   end
elseif ischar(instring)
   temp=[regexpi(instring,'[a-z][0-9]'),numel(instring)];
   elementname=instring(1:temp(1));
elseif iscell(instring)
   elementname=cell(1,numel(instring));
   for i=1:numel(instring)
      temp=[regexpi(instring{i},'[a-z][0-9]'),numel(instring{i})];
      elementname{i}=instring{i}(1:temp(1));
   end
end

function preconnmap(connmap)
global elemlist;
global spdmin spdmax;
spdmin=zeros(numel(elemlist),numel(elemlist))+2;
spdmax=zeros(numel(elemlist),numel(elemlist))+4;
for k=1:size(connmap,1)
   ind1=strcmpi(connmap{k,1},elemlist);ind2=strcmpi(connmap{k,2},elemlist);
   spdmin(ind1,ind2)=connmap{k,3}; spdmin(ind2,ind1)=connmap{k,3};
   spdmax(ind1,ind2)=connmap{k,4}; spdmax(ind2,ind1)=connmap{k,4};
end

function rngout=getrange(instring,i,j,num)
global spdmin spdmax;
rngout=zeros(numel(i),numel(j),2);
if ~ischar(instring)
   if numel(instring)==1 instring=[0.01,instring]; end
   rngout(:,:,1)=instring(1);rngout(:,:,2)=instring(2);
else
   if strcmpi(instring,'default')
      rngout(:,:,1)=spdmin(i,j);
      rngout(:,:,2)=spdmax(i,j);
   end
end
if nargin==4
   rngout=rngout(:,:,num);
end

function sitelist=siteselect(instring)
global atomlist bondlist atomused unitcelllist;
if ~ischar(instring)
   sitelist=unique(instring);
else
   strarray0=regexp(instring,'&&','split');
   if numel(strarray0)>1
      sitelist=1:numel(atomlist);
      for k=1:numel(strarray0)
         sitelist=intersect(sitelist,siteselect(strarray0{k}));
      end
      return;
   else
      strarray=regexp(instring,' ','split');
      sitematrix={[],[]};
      flagcount=[0,0];
      siteall=1:numel(atomlist);
      for jj=strarray
         if isempty(jj{1}) continue;
         elseif ~strcmpi(jj{1}(1),'-')
            j=jj{1};
            flag=1;
         else
            j=jj{1}(2:end);
            flag=2;
         end
         flagcount(flag)=flagcount(flag)+1;
         if strcmpi(j,'all') sitematrix{flag}=[sitematrix{flag},siteall(~ismember(getelem(siteall),{'&','Dummy'}))];
         elseif strcmpi(j,'used') sitematrix{flag}=[sitematrix{flag},atomused];
         elseif strcmpi(j,'bonded') sitematrix{flag}=[sitematrix{flag},bondlist];
         elseif strcmpi(j,'unitcell') sitematrix{flag}=[sitematrix{flag},unitcelllist];
         elseif all(ismember(j,'0123456789:,[]')) sitematrix{flag}=[sitematrix{flag},str2num(j)]; %#ok<ST2NM>
         elseif strcmpi(j,getelem(j)) sitematrix{flag}=[sitematrix{flag},siteall(strcmpi(j,getelem(siteall)))];
         else sitematrix{flag}=[sitematrix{flag},siteall(strcmpi(j,atomlist))];
         end
      end
      if (flagcount(1)==0)&&(flagcount(2)~=0) sitematrix{1}=siteall(~ismember(getelem(siteall),{'&','Dummy'})); end
      sitelist=setdiff(sitematrix{1},sitematrix{2});
   end
end

function rnglist=rngselect(rngtype,rngref,siteref)
global x y z;
global unitcell;
if nargin<3 siteref='all'; end
sitelist=siteselect(siteref);
if strcmpi(rngtype,'sphere')
   if numel(rngref{1})==1 center=[x(rngref{1}),y(rngref{1}),z(rngref{1})];
   else center=rngref{1}; end
   if strcmpi(rngref{2},'direct')&&numel(rngref{1})==3 center=center*unitcell; end
   rnglist=sitelist(sum(bsxfun(@minus,[x(sitelist),y(sitelist),z(sitelist)],center).^2,2).^0.5<rngref{3});
elseif strcmpi(rngtype,'box')
   if numel(rngref{1})==1 center=[x(rngref{1}),y(rngref{1}),z(rngref{1})];
   else center=rngref{1}; end
   if strcmpi(rngref{2},'direct')&&numel(rngref{1})==3 center=center*unitcell; end
   if numel(rngref{3})==3 rng=rngref{3};
   else rng=[rngref{3},rngref{3},rngref{3}];
   end
   rnglist=sitelist((abs(x(sitelist)-center(1))<rng(1))&(abs(y(sitelist)-center(2))<rng(2))&(abs(z(sitelist)-center(3))<rng(3)));
elseif strcmpi(rngtype,'slab')
   if numel(rngref{1})==3 points=[x(rngref{1}),y(rngref{1}),z(rngref{1})];
   else points=rngref{1}; end
   if strcmpi(rngref{2},'direct')&&numel(rngref{1})==9 points=points*unitcell; end
   rnglist=sitelist(d2plane(sitelist,points)<rngref{3});
end

function colordepth(depthcueingin)
global depthcueing;
depthcueing=depthcueingin;

function colordepth0()
global depthcueing objlist imgbound;
global x y z;
global bnorm;
if isempty(depthcueing) return; end
for k=1:size(objlist,1)
   if ismember(objlist{k,2},{'atom','bondb','bondu'})
      boffset=mean([x(objlist{k,3}),y(objlist{k,3}),z(objlist{k,3})]*bnorm');
      colorfactor=1-(imgbound(5)-boffset)/(imgbound(5)-imgbound(2))*depthcueing;
      colorfactor=max([min([colorfactor,1]),0]);
      if strcmp(objlist{k,2},'bondb') set(objlist{k,1},'cData',get(objlist{k,1},'cData')*colorfactor);
      else set(objlist{k,1},'FaceColor',get(objlist{k,1},'FaceColor')*colorfactor);
      end
   elseif strcmp(objlist{k,2},'poly')
      for l=1:numel(objlist{k,1})
         boffset=mean([get(objlist{k,1}(l),'XData'),get(objlist{k,1}(l),'YData'),get(objlist{k,1}(l),'ZData')]*bnorm');
         colorfactor=1-(imgbound(5)-boffset+0.0001)/(imgbound(5)-imgbound(2)+0.0002)*depthcueing;
         colorfactor=max([min([colorfactor,1]),0]);
         set(objlist{k,1}(l),'FaceColor',get(objlist{k,1}(l),'FaceColor')*colorfactor);
      end
   end
end

function fadealpha(faderadiusin)
global faderadius;
faderadius=faderadiusin;

function fadealpha0()
global faderadius objlist;
global x y z;
if isempty(faderadius) return; end
if numel(faderadius)==1 faderadius=[-0.001,faderadius]; end
viewingposition=campos;
for k=1:size(objlist,1)
   if ismember(objlist{k,2},{'atom','bondb','bondu'})
      rdist=mean(sum(bsxfun(@minus,[x(objlist{k,3}),y(objlist{k,3}),z(objlist{k,3})],viewingposition).^2,2).^0.5);
      fadefactor=(faderadius(2)-rdist)/(faderadius(2)-faderadius(1));fadefactor=max(min(fadefactor,1),0);
      set(objlist{k,1},'FaceAlpha',get(objlist{k,1},'FaceAlpha')*fadefactor);
   elseif strcmp(objlist{k,2},'poly')
      for l=1:numel(objlist{k,1})
         rdist=mean(sum(bsxfun(@minus,[get(objlist{k,1}(l),'XData'),get(objlist{k,1}(l),'YData'),get(objlist{k,1}(l),'ZData')],viewingposition).^2,2).^0.5);
         fadefactor=(faderadius(2)-rdist)/(faderadius(2)-faderadius(1));fadefactor=max(min(fadefactor,1),0);
         set(objlist{k,1}(l),'FaceAlpha',get(objlist{k,1}(l),'FaceAlpha')*fadefactor);
      end
   end
end

%  Functions arrow3d and rotatedata are obtained from MathWorks file exchange. Original comments have been removed.
%  http://www.mathworks.com/matlabcentral/fileexchange/8396-draw-3d-arrows/ (author: Changshun Deng)

function arrow3d(start,stop,ang,ltype,p,n)
dvec=stop-start;
dis=sqrt(sum(dvec.^2,2));
hv=min(dis)*p(1);
init_stop=[zeros(size(dis)) zeros(size(dis)) (dis-hv).*ones(size(dis))];
cosrang=acos(dvec(:,3)./dis);
nvec=[-dvec(:,2) dvec(:,1) zeros(size(dis))];
if strcmpi(ltype,'line')
   for i=1:length(dis)
      [rx,ry,rz]=rotatedata(init_stop(i,1),init_stop(i,2),init_stop(i,3),nvec(i,:),cosrang(i),[0,0,0]);
      line([start(i,1);start(i,1)+rx],[start(i,2);start(i,2)+ry],[start(i,3);start(i,3)+rz]);
   end
else
   for i=1:length(dis)
      r=hv*tan(ang).*p(2);
      [xi,yi,zi]=cylinder(r.*[1,1],n(2));
      zi=zi.*(dis(i)-hv);
      if all(nvec(i,:)==0)
         nvec(i,:)=[0,1,0];
      end
      [rx,ry,rz]=rotatedata(xi,yi,zi,nvec(i,:),cosrang(i),[0,0,0]);
      cx=start(i,1)+rx;cy=start(i,2)+ry;cz=start(i,3)+rz;
      surf(cx,cy,cz,'edgecolor','none','facecolor',[0 0 0],'facelighting','none');
      patch(cx(1,:),cy(1,:),cz(1,:),[0 0 0]);
   end
end
pv=dis-hv;
for i=1:length(dis)
   [xi,yi,zi]=cylinder([tan(ang),0],n(1));
   xi=xi*hv;yi=yi*hv;zi=zi*hv+pv(i);
   [rx,ry,rz]=rotatedata(xi,yi,zi,nvec(i,:),cosrang(i),[0,0,0]);
   cx=start(i,1)+rx;cy=start(i,2)+ry;cz=start(i,3)+rz;
   surf(cx,cy,cz,'edgecolor','none','facecolor',[0 0 0],'facelighting','none');
   patch(cx(1,:),cy(1,:),cz(1,:),[0 0 0]);
end

function [newx,newy,newz]=rotatedata(xdata,ydata,zdata,azel,alpha,origin)
if numel(azel)==2
   theta=azel(1);
   phi=azel(2);
   u=[cos(phi)*cos(theta);cos(phi)*sin(theta);sin(phi)];
elseif numel(azel)==3
   u=azel(:)/norm(azel);
end
alph=alpha;
cosa=cos(alph);
sina=sin(alph);
vera=1-cosa;
x0=u(1);
y0=u(2);
z0=u(3);
rot=[cosa+x0^2*vera x0*y0*vera-z0*sina x0*z0*vera+y0*sina; ...
   x0*y0*vera+z0*sina cosa+y0^2*vera y0*z0*vera-x0*sina; ...
   x0*z0*vera-y0*sina y0*z0*vera+x0*sina cosa+z0^2*vera]';
[m,n]=size(xdata);
newxyz=[xdata(:),ydata(:),zdata(:)];
newxyz=newxyz*rot;
newx=origin(1)+reshape(newxyz(:,1),m,n);
newy=origin(2)+reshape(newxyz(:,2),m,n);
newz=origin(3)+reshape(newxyz(:,3),m,n);

function coordset=coord(atomsetref,rangeref,instring)
global atomdist;
if nargin<3 instring='all'; end
if nargin<2 rangeref='default'; end
sitelist=siteselect(instring);
atomset=siteselect(atomsetref);
rangematrix=getrange(rangeref,sitelist,atomset);
coordset=sitelist(all(atomdist(sitelist,atomset)>rangematrix(:,:,1),2)&any(atomdist(sitelist,atomset)<rangematrix(:,:,2),2));

function mol=getmol(startref,instring,rangeref)
if nargin<3 rangeref='default'; end
mol=siteselect(startref);
mol0=[];
while(~isequal(mol,mol0))
   mol0=mol;
   mol=unique([mol,coord(mol,rangeref,instring)]);
end

function sitelist=drawatom(varargin)
global aup bnorm cline;
global x y z;
global res;
global objlist;
paramuse={'AC','R','AA','O','OW','OC','DL','FL','LP','ACD','RES'};
atomcolor='default'; radius='metallic 0.25'; atomalpha=1; OLflag='off'; OLcolor='default'; OLwidth=0.05; dashlength=[2,1]; facelighting='default'; resuse=res;
lightparam='default'; atomcolordata='default'; setfuncdefault(varargin(2:end),paramuse); lightparam=getlightparam(lightparam,[0.6,0.6,0.9,10]);
if strcmpi(facelighting,'default')
   if strcmpi(OLflag,'dash') facelighting='none'; else facelighting='gouraud'; end
end
sitelist=siteselect(varargin{1});
atomupdate(sitelist);
atomcoloruse=atomcolorlookup(atomcolor,sitelist);
OLcoloruse=atomcolorlookup(OLcolor,sitelist);
radiususe=atomradiuslookup(radius,sitelist);
for i=1:numel(sitelist)
   ir=sitelist(i);
   res0=round(20+(3+10*radiususe(i))*resuse);
   nx=x(ir); ny=y(ir); nz=z(ir);
   [Xnew,Ynew,Znew]=sphere(res0);
   temp=[Xnew(:),Ynew(:),Znew(:)]*[-aup;-cline;bnorm]*radiususe(i);
   Xnew=reshape(temp(:,1),res0+1,res0+1)+nx;Ynew=reshape(temp(:,2),res0+1,res0+1)+ny;Znew=reshape(temp(:,3),res0+1,res0+1)+nz;
   if ~ischar(atomcolordata)
      cmHr=zeros(size(Xnew,1),size(Xnew,2));cmHg=zeros(size(Xnew,1),size(Xnew,2));cmHb=zeros(size(Xnew,1),size(Xnew,2));rcount=0;
      for k=1:size(atomcolordata,1)
         tempcolor=atomcolorlookup('default',atomcolordata(k,1));tempsum=floor(sum([atomcolordata{1:k,2}])*(res0+1));
         cmHr(:,rcount+1:tempsum)=tempcolor(1);cmHg(:,rcount+1:tempsum)=tempcolor(2);cmHb(:,rcount+1:tempsum)=tempcolor(3);rcount=tempsum;
      end
      cmH(:,:,1)=cmHr;cmH(:,:,2)=cmHg;cmH(:,:,3)=cmHb;
      hdltemp=surf(Xnew,Ynew,Znew,'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4),...
         'FaceAlpha',atomalpha,'EdgeColor','none','CData',cmH,'FaceLighting',facelighting,'Clipping','off','DisplayName',atominfo(ir));
   else
      hdltemp=surf(Xnew,Ynew,Znew,'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4),...
         'FaceAlpha',atomalpha,'EdgeColor','none','FaceColor',atomcoloruse(i,:),'FaceLighting',facelighting,'Clipping','off','DisplayName',atominfo(ir));
   end
   objlist(end+1,1:3)={hdltemp,'atom',ir};
   if ~strcmpi(OLflag,'off')
      theta=0:2*pi/(72+6*resuse):2*pi;
      seg=round(OLwidth/(2*pi/(72+6*resuse)*radiususe(i)));
      peri0=bsxfun(@plus,[nx,ny,nz]',(aup'*cos(theta)+cline'*sin(theta))*radiususe(i));
      peri1=[peri0(:,2:size(theta,2)),peri0(:,2)];
      peri3=bsxfun(@plus,[nx,ny,nz]',(aup'*cos(theta)+cline'*sin(theta))*(radiususe(i)+OLwidth));
      peri2=[peri3(:,2:size(theta,2)),peri3(:,2)];
      cylX=[peri0(1,:);peri1(1,:);peri2(1,:);peri3(1,:)];
      cylY=[peri0(2,:);peri1(2,:);peri2(2,:);peri3(2,:)];
      cylZ=[peri0(3,:);peri1(3,:);peri2(3,:);peri3(3,:)];
      if ~strcmpi(OLflag,'dash')
         surf(cylX,cylY,cylZ,'FaceColor',OLcoloruse(i,:),'Facelighting','none','LineStyle','none');
      else
         cmH=ones(3,size(peri0,2),3);
         for j=1:size(peri0,2)
            if rem(floor(j/seg),sum(dashlength))>=dashlength(2)
               cmH(:,j,:)=[OLcoloruse(i,:);OLcoloruse(i,:);OLcoloruse(i,:)];
            end
         end
         surf(cylX,cylY,cylZ,cmH,'Facelighting','none','LineStyle','none');
      end
   end
end

function atomset=drawbond(varargin)
global atomdist x y z;
global aup bnorm;
global res;
global bondlist objlist;
paramuse={'RN','BC','BW','BT','BA','BS','O','OW','OC','DL','FL','LP','RES'};
range='default'; bondcolor='default'; bondwidth=0.15; bondtype='regular'; bondalpha=1; OLflag='off'; OLwidth=0.05; OLcolor=[1,1,1]; dashlength=[2,1];
facelighting='default'; lightparam='default'; resuse=res; bondsep=0.1;
if mod(numel(varargin),2)==0 sitelist1=siteselect(varargin{1}); sitelist2=siteselect(varargin{2}); setfuncdefault(varargin(3:end),paramuse);
else sitelist1=siteselect(varargin{1}); sitelist2=sitelist1; setfuncdefault(varargin(2:end),paramuse);
end
lightparam=getlightparam(lightparam,[0.4,0.6,0.9,10]);
if strcmpi(facelighting,'default')
   if strcmpi(bondtype,'dash') facelighting='none'; else facelighting='gouraud'; end
end
rangematrix=getrange(range,sitelist1,sitelist2);
bfmatrix=(atomdist(sitelist1,sitelist2)>=rangematrix(:,:,1))&(atomdist(sitelist1,sitelist2)<=rangematrix(:,:,2));
flag=zeros(numel(x));
atomset=union(sitelist1(any(bfmatrix,2)),sitelist2(any(bfmatrix,1)));
for i=1:numel(sitelist1)
   for j=1:numel(sitelist2)
      ir=sitelist1(i);jr=sitelist2(j);
      if (~bfmatrix(i,j)||ir==jr||flag(ir,jr)) continue; end
      flag(ir,jr)=1;
      flag(jr,ir)=1;
      if strcmpi(bondtype,'dash')&&strcmpi(bondcolor,'default') bondcoloruse=[0,0,0,1,1,1];
      else bondcoloruse=bondcolorlookup(bondcolor,ir,jr);
      end
      if strcmpi(bondtype,'dash')
         bondlength=atomdist(ir,jr);
         [cylX,cylY,cylZ]=cylinder(bondwidth/2*ones(1,round(bondlength/bondwidth)+1),round(10+(1+8*bondwidth)*resuse));
      elseif numel(bondcoloruse)==6
         [cylX,cylY,cylZ]=cylinder(bondwidth/2*[1,1,1],round(10+(1+8*bondwidth)*resuse));
      else
         [cylX,cylY,cylZ]=cylinder(bondwidth/2*[1,1],round(10+(1+8*bondwidth)*resuse));
      end
      cylZ=cylZ*atomdist(ir,jr);
      xp=x(jr)-x(ir); yp=y(jr)-y(ir); zp=z(jr)-z(ir);
      bondlength=atomdist(ir,jr);
      bondnorm=[xp,yp,zp]/bondlength;
      rotateangle=atan2(norm(cross([0,0,1],bondnorm)),dot([0,0,1],bondnorm));
      rotateaxis=cross([0,0,1],bondnorm);
      if norm(rotateaxis)==0 rotateaxis=[1,0,0]; end
      [cylX,cylY,cylZ]=rotatedata(cylX,cylY,cylZ,rotateaxis,rotateangle,[x(ir),y(ir),z(ir)]);
      cvec=cross(bnorm,[x(jr)-x(ir),y(jr)-y(ir),z(jr)-z(ir)]); if norm(cvec)==0 cvec=aup; end
      cvec=cvec/norm(cvec)*(bondwidth+bondsep)/2;
      if strcmpi(bondtype,'regular')||strcmpi(bondtype,'dash') nbonds=1; bondshift=[0,0,0];
      elseif strcmpi(bondtype,'double') nbonds=2; bondshift=[cvec;-cvec];
      elseif strcmpi(bondtype,'triple') nbonds=3; bondshift=[2*cvec;0,0,0;-2*cvec];
      elseif strcmpi(bondtype,'quadruple') nbonds=4; bondshift=[3*cvec;cvec;-cvec;-3*cvec];   
      end
      if strcmpi(bondtype,'dash')
         if numel(bondcoloruse)==3 bondcoloruse=[bondcoloruse,1,1,1]; end
         cmH=zeros(size(cylZ,1),size(cylZ,2),3);
         for k=1:size(cmH,1)
            if rem(k,sum(dashlength))<dashlength(2) cmH(k,:,:)=repmat(bondcoloruse(4:6),size(cylZ,2),1);
            else cmH(k,:,:)=repmat(bondcoloruse(1:3),size(cylZ,2),1);
            end
         end
         hdltemp=surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),...
            'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4),'CData',cmH,...
            'FaceLighting',facelighting,'DisplayName',['bond between ',atominfo(ir),' and ',atominfo(jr),', d=',num2str(bondlength)]);
         objlist(end+1,1:3)={hdltemp,'bondd',[ir,jr]};
      elseif size(bondcoloruse,2)==6
         cmH0=zeros(2,1,3);
         cmH0(1,1,:)=bondcoloruse(1:3);
         cmH0(2,1,:)=bondcoloruse(4:6);
         cmH=repmat(cmH0,[1 size(cylX,2) 1]);
         for k=1:nbonds
            hdltemp=surf(cylX+bondshift(k,1),cylY+bondshift(k,2),cylZ+bondshift(k,3),'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',...
               lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4),...
               'CData',cmH,'DisplayName',['bond between ',atominfo(ir),' and ',atominfo(jr),', d=',num2str(bondlength)]);
            objlist(end+1,1:3)={hdltemp,'bondb',[ir,jr]};
         end
      else
         for k=1:nbonds
            hdltemp=surf(cylX+bondshift(k,1),cylY+bondshift(k,2),cylZ+bondshift(k,3),'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',...
               lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4),'FaceColor',bondcoloruse,...
               'DisplayName',['bond between ',atominfo(ir),' and ',atominfo(jr),', d=',num2str(bondlength)]);
            objlist(end+1,1:3)={hdltemp,'bondu',[ir,jr]};
         end
      end
      if strcmpi(OLflag,'on')
         lview=cross(bnorm,[xp,yp,zp]);
         vect1=lview/norm(lview)*(0.5*bondwidth+OLwidth);
         vect2=lview/norm(lview)*0.5*bondwidth;
         wlrect1=[x(ir),y(ir),z(ir);x(ir),y(ir),z(ir);x(jr),y(jr),z(jr);x(jr),y(jr),z(jr)]+[vect1;vect2;vect2;vect1];
         wlrect2=[x(ir),y(ir),z(ir);x(ir),y(ir),z(ir);x(jr),y(jr),z(jr);x(jr),y(jr),z(jr)]-[vect1;vect2;vect2;vect1];
         for k=1:nbonds
            fill3(wlrect1(:,1)+bondshift(k,1),wlrect1(:,2)+bondshift(k,2),wlrect1(:,3)+bondshift(k,3),OLcolor,'FaceLighting','none',...
               'EdgeColor','none','AmbientStrength',.4,'FaceAlpha',bondalpha,'Linewidth',.3);
            fill3(wlrect2(:,1)+bondshift(k,1),wlrect2(:,2)+bondshift(k,2),wlrect2(:,3)+bondshift(k,3),OLcolor,'FaceLighting','none',...
               'EdgeColor','none','AmbientStrength',.4,'FaceAlpha',bondalpha,'Linewidth',.3);
         end
      end
   end
end
atomupdate(atomset);
bondlist=unique([bondlist,atomset]);

function drawbondx(point1,point2,bondtype,dashlength,bondcolor,bondwidth,bondalpha,OLflag,OLwidth,OLcolor,facelighting,resuse)
global bnorm;
xp=point2(1)-point1(1);
yp=point2(2)-point1(2);
zp=point2(3)-point1(3);
length=norm(point2-point1);
xylength=norm([xp yp]);
if xylength>0
   sinphi=yp/xylength;
   cosphi=xp/xylength;
else
   sinphi=0;
   cosphi=1;
end
sintheta=xylength/length;
costheta=zp/length;
phirot=[cosphi -sinphi 0;sinphi cosphi 0;0 0 1];
thetarot=[costheta 0 sintheta;0 1 0;-sintheta 0 costheta];
if strcmpi(bondtype,'dash')
   [cylX,cylY,cylZ]=cylinder(bondwidth/2*ones(1,round(length/bondwidth)+1),round(10+(1+8*bondwidth)*resuse));
else
   [cylX,cylY,cylZ]=cylinder(bondwidth/2*[1,1],round(10+(1+8*bondwidth)*resuse));
end
cylZ=cylZ*length;
[m,n]=size(cylZ);
newcylpoint=bsxfun(@plus,[cylX(:),cylY(:),cylZ(:)]*thetarot'*phirot',point1);
cylX=reshape(newcylpoint(:,1),m,n);
cylY=reshape(newcylpoint(:,2),m,n);
cylZ=reshape(newcylpoint(:,3),m,n);
if strcmpi(bondtype,'dash')
   cmH=zeros(size(cylZ,1),size(cylZ,2),3);
   for k=1:size(cmH,1)
      if rem(k,sum(dashlength))<dashlength(2) cmH(k,:,:)=1; end
   end
   surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',.4,'CData',cmH,'FaceLighting',facelighting,'Linewidth',.3,'DisplayName','cell edge');
else
   surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',.4,'FaceColor',bondcolor,'FaceLighting',facelighting,'Linewidth',.3,'DisplayName','cell edge');
end
if strcmpi(OLflag,'on')
   lview=cross(bnorm,[xp,yp,zp]);
   vect1=lview/norm(lview)*(0.5*bondwidth+OLwidth);
   vect2=lview/norm(lview)*0.5*bondwidth;
   wlrect1=[point1(1),point1(2),point1(3);point1(1),point1(2),point1(3);point2(1),point2(2),point2(3);point2(1),point2(2),point2(3)]+[vect1;vect2;vect2;vect1];
   wlrect2=[point1(1),point1(2),point1(3);point1(1),point1(2),point1(3);point2(1),point2(2),point2(3);point2(1),point2(2),point2(3)]-[vect1;vect2;vect2;vect1];
   fill3(wlrect1(:,1),wlrect1(:,2),wlrect1(:,3),OLcolor,'FaceLighting','none','EdgeColor','none','AmbientStrength',.4,'FaceAlpha',1,'Linewidth',.3);
   fill3(wlrect2(:,1),wlrect2(:,2),wlrect2(:,3),OLcolor,'FaceLighting','none','EdgeColor','none','AmbientStrength',.4,'FaceAlpha',1,'Linewidth',.3);
end

function drawcell(varargin)
global unitcell cellbound res;
paramuse={'RN','OR','CT','BT','BC','BW','BA','O','OC','OW','DL','FL','RES'};
range='default'; OLflag='off'; OLwidth=0.03; OLcolor=[1,1,1]; bondtype='regular'; bondcolor=[0,0,0]; bondwidth=0.06; bondalpha=1; dashlength=[2,1];
facelighting='default'; origin=[0,0,0]; resuse=res; coordtype='direct'; setfuncdefault(varargin,paramuse);
if strcmpi(facelighting,'default')
   if strcmpi(bondtype,'dash') facelighting='none'; else facelighting='gouraud'; end
end
if abs(det(unitcell))<0.001 error('Wrong cell vectors!'); end
if strcmpi(coordtype,'direct') origin=origin*unitcell; end
if ischar(range)
   if strcmpi(range,'default')
      if isequal(cellbound,[1000,1000,1000,-1000,-1000,-1000]) [xr,yr,zr]=meshgrid([0,1],[0,1],[0,1]); frac=[xr(:),yr(:),zr(:)];
      else
         [xr,yr,zr]=meshgrid([cellbound(1),cellbound(4)],[cellbound(2),cellbound(5)],[cellbound(3),cellbound(6)]);
         frac=[xr(:),yr(:),zr(:)]/unitcell;
      end
      boundvec=[min(frac,[],1);max(frac,[],1)];
      xmin=round(boundvec(1,1));ymin=round(boundvec(1,2));zmin=round(boundvec(1,3));
      xmax=round(boundvec(2,1));ymax=round(boundvec(2,2));zmax=round(boundvec(2,3));
      if xmin==xmax
         xmin=xmin-(abs(xmin+0.001-boundvec(1,1))>abs(xmax-0.002-boundvec(2,1)));
         xmax=xmax+(abs(xmin+0.001-boundvec(1,1))<abs(xmax-0.002-boundvec(2,1)));
      end
      if ymin==ymax
         ymin=ymin-(abs(ymin+0.001-boundvec(1,2))>abs(ymax-0.002-boundvec(2,2)));
         ymax=ymax+(abs(ymin+0.001-boundvec(1,2))<abs(ymax-0.002-boundvec(2,2)));
      end
      if zmin==zmax
         zmin=zmin-(abs(zmin+0.001-boundvec(1,3))>abs(zmax-0.002-boundvec(2,3)));
         zmax=zmax+(abs(zmin+0.001-boundvec(1,3))<abs(zmax-0.002-boundvec(2,3)));
      end
   elseif strcmpi(range,'unitcell')
      xmin=0;xmax=1;ymin=0;ymax=1;zmin=0;zmax=1;
   end
elseif isnumeric(range)&&numel(range)==3
   xmin=-floor(range(1)/2); xmax=ceil(range(1)/2);
   ymin=-floor(range(2)/2); ymax=ceil(range(2)/2);
   zmin=-floor(range(3)/2); zmax=ceil(range(3)/2);
elseif isnumeric(range)&&numel(range)==6
   xmin=range(1); xmax=range(2); ymin=range(3); ymax=range(4); zmin=range(5); zmax=range(6);
else
   error('Unrecognized cell range!');
end
for i=xmin:xmax
   for j=ymin:ymax
      for k=zmin:zmax
         if i~=xmax
            drawbondx([i j k]*unitcell+origin,[i+1 j k]*unitcell+origin,bondtype,dashlength,bondcolor,bondwidth,bondalpha,OLflag,OLwidth,OLcolor,facelighting,resuse);
         end
         if j~=ymax
            drawbondx([i j k]*unitcell+origin,[i j+1 k]*unitcell+origin,bondtype,dashlength,bondcolor,bondwidth,bondalpha,OLflag,OLwidth,OLcolor,facelighting,resuse);
         end
         if k~=zmax
            drawbondx([i j k]*unitcell+origin,[i j k+1]*unitcell+origin,bondtype,dashlength,bondcolor,bondwidth,bondalpha,OLflag,OLwidth,OLcolor,facelighting,resuse);
         end
      end
   end
end
[x0,y0,z0]=meshgrid([xmin,xmax],[ymin,ymax],[zmin,zmax]); cornerx=[x0(:),y0(:),z0(:)]*unitcell+repmat(origin,8,1);
boundupdatex(cornerx);

function hulllist=drawpoly(varargin)
global x y z;
global aup bnorm cline;
global objlist res;
paramuse={'CS','CR','FC','FA','B','BC','BW','BA','DT','FL','RN','O','OW','OC','FCD','BT','DL','LP','BFL','BLP','RES'};
facecolor='default'; facealpha=1; bondflag='on'; bondcolor='default'; bondwidth=0.15; bondalpha=1; dihedraltol=1; facelighting='flat'; resuse=res;
range='default'; OLflag='off'; OLwidth=0.05; OLcolor=[1,1,1]; facecdata='default'; bondtype='regular'; dashlength=[2,1]; lightparam='default';
BLP='default'; BFL='gouraud';
sitelist=siteselect(varargin{1});
setfuncdefault(varargin(2:end),paramuse);
lightparam=getlightparam(lightparam,[1,0.6,0.1,10]);
if numel(sitelist)<3 hulllist=[]; return;
elseif numel(sitelist)==3
   vertices=[x(sitelist) y(sitelist) z(sitelist)];
   poly=[1,2,3];
   vx=x(sitelist)';
   vy=y(sitelist)';
   vz=z(sitelist)';
   coordlist=[1,2,3];
   hulllist=sitelist;
else
   vertices=[x(sitelist) y(sitelist) z(sitelist)];
   poly=convhulln(vertices);
   vx=reshape(vertices(poly,1),size(poly));
   vy=reshape(vertices(poly,2),size(poly));
   vz=reshape(vertices(poly,3),size(poly));
   coordlist=unique([poly(:,1)',poly(:,2)',poly(:,3)']);
   hulllist=sitelist(coordlist);
end
atomupdate(hulllist);
defcolor=sum(atomcolorlookup('default',sitelist(coordlist)));
if ischar(bondcolor)&&strcmpi(bondcolor,'default') bondcolor=defcolor/numel(coordlist);
elseif ischar(bondcolor)&&strcmpi(bondcolor,'bicolored') bondcolor='default';
end
if ischar(facecolor)&&strcmpi(facecolor,'default') facecolor=defcolor/numel(coordlist)*0.5+[0.5 0.5 0.5]; end
hdltemp=fill3(vx',vy',vz',facecolor,'FaceLighting',facelighting,'FaceAlpha',facealpha,'LineStyle','none','AmbientStrength',lightparam(1),...
   'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4),'BackFaceLighting','lit');
if ~ischar(facecdata)||~strcmpi(facecdata,'default')
   for k=1:size(poly,1)
      if iscell(facecdata)
         temp0=sort(getelem(sitelist(poly(k,:))))';
         for l=1:size(facecdata,1)
            temp=sort(facecdata(l,1:3));
            if all(strcmpi(temp,temp0)) set(hdltemp(k),'facecolor',facecdata{l,4}); break; end
         end
      elseif ischar(facecdata)&&strcmpi(facecdata,'mix')
         temp=[0,0,0];
         for l=1:3
            temp=temp+atomcolorlookup('light',getelem(sitelist(poly(k,l))))/3;
         end
         set(hdltemp(k),'facecolor',temp);
      end
   end
end
objlist(end+1,1:3)={hdltemp,'poly',hulllist};
if strcmpi(bondflag,'on')&&numel(poly)~=3
   flag=zeros(size(x,1));
   for i=1:size(poly,1)
      xi=sitelist(poly(i,1));
      yi=sitelist(poly(i,2));
      zi=sitelist(poly(i,3));
      if flag(xi,yi)==0
         flag(yi,xi)=zi;
      else
         if (dihedral(xi,yi,zi,flag(xi,yi))>pi/180*dihedraltol)
            drawbond(xi,yi,'RN',range,'BT',bondtype,'DL',dashlength,'BC',bondcolor,'BW',bondwidth,'BA',bondalpha,'LP',BLP,'FL',BFL,'RES',resuse);
         end
      end
      if flag(yi,zi)==0
         flag(zi,yi)=xi;
      else
         if (dihedral(yi,zi,xi,flag(yi,zi))>pi/180*dihedraltol)
            drawbond(yi,zi,'RN',range,'BT',bondtype,'DL',dashlength,'BC',bondcolor,'BW',bondwidth,'BA',bondalpha,'LP',BLP,'FL',BFL,'RES',resuse);
         end
      end
      if flag(zi,xi)==0
         flag(xi,zi)=yi;
      else
         if (dihedral(zi,xi,yi,flag(zi,xi))>pi/180*dihedraltol)
            drawbond(zi,xi,'RN',range,'BT',bondtype,'DL',dashlength,'BC',bondcolor,'BW',bondwidth,'BA',bondalpha,'LP',BLP,'FL',BFL,'RES',resuse);
         end
      end
   end
elseif strcmpi(bondflag,'on')&&numel(poly)==3
   drawbond(sitelist,'RN',range,'BT',bondtype,'DL',dashlength,'BC',bondcolor,'BW',bondwidth,'BA',bondalpha,'LP',BLP,'FL',BFL,'RES',resuse);
end
if strcmpi(OLflag,'on')
   if strcmpi(bondflag,'on')
      OLwidth=0.5*bondwidth+OLwidth;
   end
   verticesc=vertices/[aup;bnorm;cline];
   hull2d=convhull(verticesc(:,[3,1]));
   peri0=[x(sitelist(hull2d)) y(sitelist(hull2d)) z(sitelist(hull2d))]';
   lview=peri0(:,2:size(hull2d,1))-peri0(:,1:size(hull2d,1)-1);
   for i=1:size(lview,2)
      lview(:,i)=cross(lview(:,i),bnorm);
      lview(:,i)=lview(:,i)/norm(lview(:,i))*OLwidth;
   end
   lview=[lview lview(:,1)];
   peri1=peri0(:,[2:size(hull2d,1),2]);
   peri2=peri1+lview;
   peri3=peri0+lview;
   cylX=[peri0(1,:);peri1(1,:);peri2(1,:);peri3(1,:)];
   cylY=[peri0(2,:);peri1(2,:);peri2(2,:);peri3(2,:)];
   cylZ=[peri0(3,:);peri1(3,:);peri2(3,:);peri3(3,:)];
   fill3(cylX,cylY,cylZ,OLcolor,'FaceLighting','none','LineStyle','none','FaceAlpha',bondalpha);
end

function atomset=drawcoord(varargin)
paramuse={'CR','CS','FC','FA','B','BC','BW','BA','DT','FL','RN','O','OW','OC','FCD','BT','DL','LP','BFL','BLP','RES'};
coordrange='default'; coordset='all'; atomset=[];
sitelist=siteselect(varargin{1}); setfuncdefault(varargin(2:end),paramuse);
coordlist=cell(1,numel(sitelist));
for i=1:numel(sitelist)
   coordlist{i}=drawpoly(coord(sitelist(i),coordrange,coordset),varargin{2:end});
   for j=1:i-1
      if isequal(coordlist{i},coordlist{j})&&~isempty(coordlist{i}) warning('Figuretool:drawcoord',['The coordination polyhedra of atoms ',num2str(sitelist(j)),' and ',num2str(sitelist(i)),' are identical.']); end
   end
   if ~isempty(coordlist{i}) atomset=[atomset,coordlist{i}];
      if ~strcmpi(getelem(sitelist(i)),'dummy') atomset=[atomset,sitelist(i)]; end
   end
end
atomset=unique(atomset);

function readMO()
global MOfile MOdata;
inID=fopen(MOfile);
temp={{''}};counter=0;b2a=0.529177249;
while ~strcmpi(temp{1}{1},'#end_parms') temp=textscan(inID,'%s',1,'headerlines',1); counter=counter+1; end
fclose(inID);inID=fopen(MOfile);
ehtparms=textscan(inID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',counter-1,'headerlines',1);
temp=textscan(inID,'%s %f',2,'headerlines',2);aonum=temp{2}(1);monum=temp{2}(2);
MOdata=cell(1,monum);
textscan(inID,'%s',2,'headerlines',monum+1);
mocounter=1;atomcounter=0;aocounter=1;orbcounter=1;
orblist={'s','px','py','pz','dx2-y2','dz2','dxy','dxz','dyz','fz3','fxz2','fyz2','fxyz','fz(x2-y2)','fx(x2-3y2)','fy(3x2-y2)'};
currmo=cell(aonum,7);
while (true)
   temp=textscan(inID,'%s',1,'headerlines',1);
   if strcmp(temp{1}{1}(1),'#')
      MOdata{mocounter}=currmo; mocounter=mocounter+1; atomcounter=0; aocounter=1; orbcounter=1;
      if (mocounter>monum) break; else textscan(inID,'%s',1,'headerlines',1); end
   elseif strcmp(temp{1}{1}(1),';') atomcounter=atomcounter+1; elemnum=find(strcmpi(getelem(atomcounter),ehtparms{1}),1); orbcounter=1;
   else
      switch orblist{orbcounter}(1)
         case 's', qn=ehtparms{2}(elemnum); zetalist={ehtparms{3}(elemnum)/b2a,0,0,0};
         case 'p', qn=ehtparms{5}(elemnum); zetalist={ehtparms{6}(elemnum)/b2a,0,0,0};
         case 'd', qn=ehtparms{8}(elemnum); zetalist={ehtparms{9}(elemnum)/b2a,ehtparms{11}(elemnum),ehtparms{12}(elemnum)/b2a,ehtparms{13}(elemnum)};
         case 'f', qn=ehtparms{14}(elemnum); zetalist={ehtparms{15}(elemnum)/b2a,ehtparms{17}(elemnum),ehtparms{18}(elemnum)/b2a,ehtparms{19}(elemnum)};
      end
      currmo(aocounter,:)=[{atomcounter,[num2str(qn),orblist{orbcounter}],str2double(temp{1}{1})},zetalist]; aocounter=aocounter+1; orbcounter=orbcounter+1;
   end
end

function readXSF()
global xsffile xsfgrid;
inID=fopen(xsffile);
temp=textscan(inID,'%f',1,'headerlines',7);atomnum=temp{1};
temp=textscan(inID,'%f %f %f',1,'headerlines',2*atomnum+5); ngx=temp{1};ngy=temp{2};ngz=temp{3};
temp=textscan(inID,'%f',ngx*ngy*ngz,'headerlines',5);
fvalue=reshape(temp{1},[ngx,ngy,ngz]);
fmax=max(fvalue(:));fmin=min(fvalue(:));
fclose(inID);
xsfgrid={ngx,ngy,ngz,fvalue,fmin,fmax};
disp(['Read in XSF data grid. Range of data is [',num2str(fmin),',',num2str(fmax),'].']);

function drawxsf(varargin)
global x y z unitcell objlist xsfgrid;
if isempty(xsfgrid) readXSF(); end
paramuse={'RN','FC','FA','FL','LP','SM','SMS','SMD','SEC','SECC','SECA'};
isolevel=varargin{1}; facecolor=[0.5,0.5,0.5]; facealpha=1; facelighting='gouraud'; lightparam='default'; range=[0,1,0,1,0,1]; smoothflag='off';
smoothsize=3; smoothdev=0.65; sectionflag='off'; sectioncolor=[0.75,0.75,0.75]; sectionalpha=0.75;
setfuncdefault(varargin(2:end),paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
if iscell(range)
   if numel(range{1})==1 range{1}=[x(range{1}),y(range{1}),z(range{1})]/unitcell; end
   if numel(range{2})==1 range{2}=[range{2},range{2},range{2}]; end
   range=[range{1}(1)-range{2}(1),range{1}(1)+range{2}(1),range{1}(2)-range{2}(2),range{1}(2)+range{2}(2),range{1}(3)-range{2}(3),range{1}(3)+range{2}(3)];
end
ngx=xsfgrid{1}; ngy=xsfgrid{2}; ngz=xsfgrid{3}; fvalue0=xsfgrid{4};
if numel(isolevel)==2 fvalue0=(fvalue0>isolevel(1))&(fvalue0<isolevel(2)); isolevel=0.5; end
[xr,yr,zr]=meshgrid((floor(range(1)*(ngx-1)):ceil(range(2)*(ngx-1)))/(ngx-1),(floor(range(3)*(ngy-1)):ceil(range(4)*(ngy-1)))/(ngy-1),(floor(range(5)*(ngz-1)):ceil(range(6)*(ngz-1)))/(ngz-1));
xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]); sizerange=size(xr);
temp=[xr(:),yr(:),zr(:)]*unitcell;
xr=reshape(temp(:,1),sizerange);yr=reshape(temp(:,2),sizerange);zr=reshape(temp(:,3),sizerange); fvalue=zeros(sizerange);
for ka=floor(range(1)):ceil(range(2))-1
   for kb=floor(range(3)):ceil(range(4))-1
      for kc=floor(range(5)):ceil(range(6))-1
         xstart=max(floor((range(1)-ka)*(ngx-1))+1,1);xend=min(ceil((range(2)-ka)*(ngx-1))+1,ngx);
         ystart=max(floor((range(3)-kb)*(ngy-1))+1,1);yend=min(ceil((range(4)-kb)*(ngy-1))+1,ngy);
         zstart=max(floor((range(5)-kc)*(ngz-1))+1,1);zend=min(ceil((range(6)-kc)*(ngz-1))+1,ngz);
         xrstart=max(ka*(ngx-1)-floor(range(1)*(ngx-1))+1,1);xrend=min((ka+1)*(ngx-1),ceil(range(2)*(ngx-1)))-floor(range(1)*(ngx-1))+1;
         yrstart=max(kb*(ngy-1)-floor(range(3)*(ngy-1))+1,1);yrend=min((kb+1)*(ngy-1),ceil(range(4)*(ngy-1)))-floor(range(3)*(ngy-1))+1;
         zrstart=max(kc*(ngz-1)-floor(range(5)*(ngz-1))+1,1);zrend=min((kc+1)*(ngz-1),ceil(range(6)*(ngz-1)))-floor(range(5)*(ngz-1))+1;
         fvalue(xrstart:xrend,yrstart:yrend,zrstart:zrend)=fvalue0(xstart:xend,ystart:yend,zstart:zend);
      end
   end
end
if strcmpi(smoothflag,'on') fvalue=smooth3(fvalue,'gaussian',smoothsize,smoothdev); end
fighdl=patch(isosurface(xr,yr,zr,fvalue,isolevel),'FaceColor',facecolor,'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,...
   'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
objlist(end+1,1:3)={fighdl,'surf',[]};
if strcmpi(sectionflag,'on')
   fighdl=patch(isocaps(xr,yr,zr,fvalue,isolevel),'FaceColor',sectioncolor,'FaceAlpha',sectionalpha,'LineStyle','none','FaceLighting',facelighting,...
      'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
   objlist(end+1,1:3)={fighdl,'surf',[]};
end
[x0,y0,z0]=meshgrid([range(1),range(2)],[range(3),range(4)],[range(5),range(6)]); corners=[x0(:),y0(:),z0(:)]*unitcell;
boundupdatex(corners);

function drawchannel(varargin)
global x y z unitcell objlist res;
paramuse={'R','RN','FC','FA','FL','LP','SM','SMS','SMD','RES'};
radius='vdw'; facecolor=[0.5,0.5,0.5]; facealpha=1; facelighting='gouraud'; lightparam='default'; range=[0,1,0,1,0,1]; smoothflag='off';
smoothsize=3; smoothdev=0.65; resuse=res; setfuncdefault(varargin,paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
[xr,yr,zr]=meshgrid(0:1/(norm(unitcell(1,:))*round(0.5*resuse+2)):1,0:1/(norm(unitcell(2,:))*round(0.5*resuse+2)):1,0:1/(norm(unitcell(3,:))*round(0.5*resuse+2)):1);
xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]); size0=size(xr); temp=[xr(:),yr(:),zr(:)]*unitcell;
xr=reshape(temp(:,1),size0);yr=reshape(temp(:,2),size0);zr=reshape(temp(:,3),size0);
atomradiususe=atomradiuslookup(radius,siteselect('all'));
fvalue0=zeros(size0); [ka,kb,kc]=meshgrid(-1:1,-1:1,-1:1);
coordlist=[x(siteselect('all')),y(siteselect('all')),z(siteselect('all'))];
[x0,y0,z0]=sphere(8);inlist=[];
for k=1:size(coordlist,1)
   for l=1:numel(ka)
      temp=bsxfun(@plus,[x0(:),y0(:),z0(:)]*atomradiususe(k),[x(k),y(k),z(k)]+[ka(l),kb(l),kc(l)]*unitcell)/unitcell;
      if any((temp(:,1)>0)&(temp(:,1)<1)&(temp(:,2)>0)&(temp(:,2)<1)&(temp(:,3)>0)&(temp(:,3)<1))
         inlist=[inlist;([x(k),y(k),z(k)]+[ka(l),kb(l),kc(l)]*unitcell),atomradiususe(k)];
      end
   end
end
for k=1:size(inlist,1)
   temp=sum(bsxfun(@minus,[xr(:),yr(:),zr(:)],inlist(k,1:3)).^2,2)-inlist(k,4)^2;
   fvalue0(temp<0)=1;
end
if iscell(range)
   if numel(range{1})==1 range{1}=[x(range{1}),y(range{1}),z(range{1})]/unitcell; end
   if numel(range{2})==1 range{2}=[range{2},range{2},range{2}]; end
   range=[range{1}(1)-range{2}(1),range{1}(1)+range{2}(1),range{1}(2)-range{2}(2),range{1}(2)+range{2}(2),range{1}(3)-range{2}(3),range{1}(3)+range{2}(3)];
end
ngx=size(xr,1); ngy=size(xr,2); ngz=size(xr,3);
[xr,yr,zr]=meshgrid((floor(range(1)*(ngx-1)):ceil(range(2)*(ngx-1)))/(ngx-1),(floor(range(3)*(ngy-1)):ceil(range(4)*(ngy-1)))/(ngy-1),(floor(range(5)*(ngz-1)):ceil(range(6)*(ngz-1)))/(ngz-1));
xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]); sizerange=size(xr);
temp=[xr(:),yr(:),zr(:)]*unitcell;
xr=reshape(temp(:,1),sizerange);yr=reshape(temp(:,2),sizerange);zr=reshape(temp(:,3),sizerange); fvalue=zeros(sizerange);
for ka=floor(range(1)):ceil(range(2))-1
   for kb=floor(range(3)):ceil(range(4))-1
      for kc=floor(range(5)):ceil(range(6))-1
         xstart=max(floor((range(1)-ka)*(ngx-1))+1,1);xend=min(ceil((range(2)-ka)*(ngx-1))+1,ngx);
         ystart=max(floor((range(3)-kb)*(ngy-1))+1,1);yend=min(ceil((range(4)-kb)*(ngy-1))+1,ngy);
         zstart=max(floor((range(5)-kc)*(ngz-1))+1,1);zend=min(ceil((range(6)-kc)*(ngz-1))+1,ngz);
         xrstart=max(ka*(ngx-1)-floor(range(1)*(ngx-1))+1,1);xrend=min((ka+1)*(ngx-1),ceil(range(2)*(ngx-1)))-floor(range(1)*(ngx-1))+1;
         yrstart=max(kb*(ngy-1)-floor(range(3)*(ngy-1))+1,1);yrend=min((kb+1)*(ngy-1),ceil(range(4)*(ngy-1)))-floor(range(3)*(ngy-1))+1;
         zrstart=max(kc*(ngz-1)-floor(range(5)*(ngz-1))+1,1);zrend=min((kc+1)*(ngz-1),ceil(range(6)*(ngz-1)))-floor(range(5)*(ngz-1))+1;
         fvalue(xrstart:xrend,yrstart:yrend,zrstart:zrend)=fvalue0(xstart:xend,ystart:yend,zstart:zend);
      end
   end
end
if strcmpi(smoothflag,'on') fvalue=smooth3(fvalue,'gaussian',smoothsize,smoothdev); end
fighdl=patch(isosurface(xr,yr,zr,fvalue,0.5),'FaceColor',facecolor,'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,...
   'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
objlist(end+1,1:3)={fighdl,'surf',[]};
[x0,y0,z0]=meshgrid([range(1),range(2)],[range(3),range(4)],[range(5),range(6)]); corners=[x0(:),y0(:),z0(:)]*unitcell;
boundupdatex(corners);

function drawinterface(varargin)
global x y z unitcell objlist res;
paramuse={'R','RN','FC','FA','FL','LP','SM','SMS','SMD','RES','EXP'};
sitelist1=siteselect(varargin{1}); sitelist2=siteselect(varargin{2}); cexp=2.5; radius=6; facecolor=[0.5,0.5,0.5]; facealpha=1;
facelighting='gouraud'; lightparam='default'; range=[0,1,0,1,0,1]; smoothflag='off'; smoothsize=3; smoothdev=0.65; resuse=res;
setfuncdefault(varargin(3:end),paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
if numel(cexp)==1 cexp=[cexp,cexp]; end
[xr,yr,zr]=meshgrid(0:1/(norm(unitcell(1,:))*round(0.5*resuse+2)):1,0:1/(norm(unitcell(2,:))*round(0.5*resuse+2)):1,0:1/(norm(unitcell(3,:))*round(0.5*resuse+2)):1);
xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]); size0=size(xr); temp=[xr(:),yr(:),zr(:)]*unitcell;
xr=reshape(temp(:,1),size0);yr=reshape(temp(:,2),size0);zr=reshape(temp(:,3),size0);
fvalue0=zeros(prod(size0),1); 
if abs(det(unitcell))>200 [ka,kb,kc]=meshgrid(-1:1,-1:1,-1:1);
else [ka,kb,kc]=meshgrid(-2:2,-2:2,-2:2);
end
coordlist1=[x(sitelist1),y(sitelist1),z(sitelist1)];
coordlist2=[x(sitelist2),y(sitelist2),z(sitelist2)];
[x0,y0,z0]=sphere(8);testsphere=[[x0(:),y0(:),z0(:)]*radius;[x0(:),y0(:),z0(:)]*radius/2;[0,0,0]]; inlist1=[];inlist2=[];
for k=1:size(coordlist1,1)
   for l=1:numel(ka)
      temp=bsxfun(@plus,testsphere,coordlist1(k,:)+[ka(l),kb(l),kc(l)]*unitcell)/unitcell;
      if any((temp(:,1)>0)&(temp(:,1)<1)&(temp(:,2)>0)&(temp(:,2)<1)&(temp(:,3)>0)&(temp(:,3)<1))
         inlist1=[inlist1;coordlist1(k,:)+[ka(l),kb(l),kc(l)]*unitcell];
      end
   end
end
for k=1:size(coordlist2,1)
   for l=1:numel(ka)
      temp=bsxfun(@plus,testsphere,coordlist2(k,:)+[ka(l),kb(l),kc(l)]*unitcell)/unitcell;
      if any((temp(:,1)>0)&(temp(:,1)<1)&(temp(:,2)>0)&(temp(:,2)<1)&(temp(:,3)>0)&(temp(:,3)<1))
         inlist2=[inlist2;coordlist2(k,:)+[ka(l),kb(l),kc(l)]*unitcell];
      end
   end
end
for k=1:size(inlist1,1)
   temp=exp(-cexp(1)*sum(bsxfun(@minus,[xr(:),yr(:),zr(:)],inlist1(k,:)).^2,2).^0.5);
   fvalue0=fvalue0+temp;
end
for k=1:size(inlist2,1)
   temp=exp(-cexp(2)*sum(bsxfun(@minus,[xr(:),yr(:),zr(:)],inlist2(k,:)).^2,2).^0.5);
   fvalue0=fvalue0-temp;
end
if size(facecolor,1)==2
   temp=sort(fvalue0);
   fdiff=temp(round(numel(temp)*2/3))-temp(round(numel(temp)*1/3));
end
fvalue0=reshape(fvalue0,size0);
if iscell(range)
   if numel(range{1})==1 range{1}=[x(range{1}),y(range{1}),z(range{1})]/unitcell; end
   if numel(range{2})==1 range{2}=[range{2},range{2},range{2}]; end
   range=[range{1}(1)-range{2}(1),range{1}(1)+range{2}(1),range{1}(2)-range{2}(2),range{1}(2)+range{2}(2),range{1}(3)-range{2}(3),range{1}(3)+range{2}(3)];
end
ngx=size(xr,1); ngy=size(xr,2); ngz=size(xr,3);
[xr,yr,zr]=meshgrid((floor(range(1)*(ngx-1)):ceil(range(2)*(ngx-1)))/(ngx-1),(floor(range(3)*(ngy-1)):ceil(range(4)*(ngy-1)))/(ngy-1),(floor(range(5)*(ngz-1)):ceil(range(6)*(ngz-1)))/(ngz-1));
xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]); sizerange=size(xr);
temp=[xr(:),yr(:),zr(:)]*unitcell;
xr=reshape(temp(:,1),sizerange);yr=reshape(temp(:,2),sizerange);zr=reshape(temp(:,3),sizerange); fvalue=zeros(sizerange);
for ka=floor(range(1)):ceil(range(2))-1
   for kb=floor(range(3)):ceil(range(4))-1
      for kc=floor(range(5)):ceil(range(6))-1
         xstart=max(floor((range(1)-ka)*(ngx-1))+1,1);xend=min(ceil((range(2)-ka)*(ngx-1))+1,ngx);
         ystart=max(floor((range(3)-kb)*(ngy-1))+1,1);yend=min(ceil((range(4)-kb)*(ngy-1))+1,ngy);
         zstart=max(floor((range(5)-kc)*(ngz-1))+1,1);zend=min(ceil((range(6)-kc)*(ngz-1))+1,ngz);
         xrstart=max(ka*(ngx-1)-floor(range(1)*(ngx-1))+1,1);xrend=min((ka+1)*(ngx-1),ceil(range(2)*(ngx-1)))-floor(range(1)*(ngx-1))+1;
         yrstart=max(kb*(ngy-1)-floor(range(3)*(ngy-1))+1,1);yrend=min((kb+1)*(ngy-1),ceil(range(4)*(ngy-1)))-floor(range(3)*(ngy-1))+1;
         zrstart=max(kc*(ngz-1)-floor(range(5)*(ngz-1))+1,1);zrend=min((kc+1)*(ngz-1),ceil(range(6)*(ngz-1)))-floor(range(5)*(ngz-1))+1;
         fvalue(xrstart:xrend,yrstart:yrend,zrstart:zrend)=fvalue0(xstart:xend,ystart:yend,zstart:zend);
      end
   end
end
if strcmpi(smoothflag,'on') fvalue=smooth3(fvalue,'gaussian',smoothsize,smoothdev); end
if size(facecolor,1)==1
   fighdl=patch(isosurface(xr,yr,zr,fvalue,0),'FaceColor',facecolor,'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,...
      'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
   objlist(end+1,1:3)={fighdl,'surf',[]};
elseif size(facecolor,1)==2
   fighdl=patch(isosurface(xr,yr,zr,fvalue,fdiff/200),'FaceColor',facecolor(1,:),'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,...
      'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
   objlist(end+1,1:3)={fighdl,'surf',[]};
   fighdl=patch(isosurface(xr,yr,zr,fvalue,-fdiff/200),'FaceColor',facecolor(2,:),'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,...
      'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
   objlist(end+1,1:3)={fighdl,'surf',[]};
end
[x0,y0,z0]=meshgrid([range(1),range(2)],[range(3),range(4)],[range(5),range(6)]); corners=[x0(:),y0(:),z0(:)]*unitcell;
boundupdatex(corners);

function sitelist=drawmu3(varargin)
global mu3file;
global x y z;
global objlist res;
paramuse={'AA','O','OC','OW','RES'};
sitelist=siteselect(varargin{1}); scale=varargin{2}; OLwidth=0.05; OLcolor='default'; OLflag='on'; atomalpha=1; resuse=res;
setfuncdefault(varargin(3:end),paramuse);
atomsfile=strcat(mu3file,'-geo');
cellfile=strcat(mu3file,'-cell');
muoutput=strcat(mu3file,'.mu3output');
[~,xa,ya,za]=textread(atomsfile,'%s %f %f %f');
[a1,a2,a3]=textread(cellfile,'%f %f %f');
[~,occopt,occin]=textread(muoutput,'%f %f %f');
celluse=[a1,a2,a3];
for ir=sitelist
   for j=1:size(xa)
      temp=[xa(j)-x(ir),ya(j)-y(ir),za(j)-z(ir)]/celluse;
      if norm(temp-round(temp))<0.001
         s=(occopt(j)-occin(j))*scale;
         if s<0 color=[0,0,0]; s=-s;
         else color=[0.8,0.8,0.8];
         end
         drawatom(ir,'AC',color,'AA',atomalpha,'R',s,'O',OLflag,'OC',OLcolor,'OW',OLwidth,'RES',resuse);
         objlist{end,2}='mu3';
         atomupdate(ir);
         break;
      end
   end
end

function sitelist=drawCP(varargin)
global CPfile CMfile res;
global x y z;
paramuse={'M','O','OC','OW','LM','LA','LC','LP','FL','RES'};
sitelist=siteselect(varargin{1}); scale=varargin{2}; OLwidth=0.05; OLcolor=[1,1,1]; OLflag='off'; lmax=99; lobecolor='default'; facelighting='gouraud'; resuse=res;
lightparam='default'; lobealpha=[1,0.25]; mode='CP'; setfuncdefault(varargin(3:end),paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
if (strcmpi(mode,'both')||strcmpi(mode,'mixed'))&&ischar(lobecolor)&&strcmpi(lobecolor,'default') lobecolor=[0.8,0.8,0.8,0,0,0;1,0,0,0,0,1]; end
CPatomsfile=strcat(CPfile,'-geo'); CPcellfile=strcat(CPfile,'-cell'); CPcoefile=strcat(CPfile,'-coeff');
CMatomsfile=strcat(CMfile,'-geo'); CMcellfile=strcat(CMfile,'-cell'); CMcoefile=strcat(CMfile,'-coeff');
if strcmpi(mode,'CP')
   [~,xa,ya,za]=textread(CPatomsfile,'%s %f %f %f'); [a1,a2,a3]=textread(CPcellfile,' %f %f %f'); [~,CPcoeff]=textread(CPcoefile,'%s %f');
elseif strcmpi(mode,'CM')
   [~,xa,ya,za]=textread(CMatomsfile,'%s %f %f %f'); [a1,a2,a3]=textread(CMcellfile,' %f %f %f'); [~,CPcoeff]=textread(CMcoefile,'%s %f');
elseif strcmpi(mode,'both')||strcmpi(mode,'mixed')
   [~,xa,ya,za]=textread(CPatomsfile,'%s %f %f %f'); [a1,a2,a3]=textread(CPcellfile,' %f %f %f'); [~,CPcoeff]=textread(CPcoefile,'%s %f'); [~,CMcoeff]=textread(CMcoefile,'%s %f');
end
celluse=[a1,a2,a3];
atomnum=size(xa,1);
size_coeff=size(CPcoeff,1)/atomnum;
lmax0=sqrt(size_coeff)-1;
lmaxuse=min([lmax,lmax0]);
if strcmpi(mode,'CP')||strcmpi(mode,'CM')
   atom_coeff=reshape(CPcoeff,size_coeff,atomnum);
   atom_coeff(1:(lmaxuse+1)^2,:)=atom_coeff(1:(lmaxuse+1)^2,:)*scale(1);
   atom_coeff((lmaxuse+1)^2+1:(lmax+1)^2,:)=0;
   for ir=sitelist
      for j=1:size(xa)
         temp=[xa(j)-x(ir),ya(j)-y(ir),za(j)-z(ir)]/celluse;
         if norm(temp-round(temp))<0.001
            draworb(ir,lmaxuse,scale(1),atom_coeff(:,j),lobecolor,lobealpha(1),OLflag,OLcolor,OLwidth,'complex',lightparam,facelighting,resuse,mode);
            atomupdate(ir);
            break;
         end
      end
   end
elseif strcmpi(mode,'both')
   if numel(scale)==1 scale=[scale,scale]; end
   CPatom_coeff=reshape(CPcoeff,size_coeff,atomnum);
   CPatom_coeff(1:(lmaxuse+1)^2,:)=CPatom_coeff(1:(lmaxuse+1)^2,:)*scale(1);
   CPatom_coeff((lmaxuse+1)^2+1:(lmax+1)^2,:)=0;
   CMatom_coeff=reshape(CMcoeff,size_coeff,atomnum);
   CMatom_coeff(1:(lmaxuse+1)^2,:)=CMatom_coeff(1:(lmaxuse+1)^2,:)*scale(2);
   CMatom_coeff((lmaxuse+1)^2+1:(lmax+1)^2,:)=0;
   if isnumeric(lobecolor)&&numel(lobecolor)==12 CPlobecolor=lobecolor(1,:); CMlobecolor=lobecolor(2,:);
   else CPlobecolor=lobecolor; CMlobecolor=lobecolor;
   end
   for ir=sitelist
      for j=1:size(xa)
         temp=[xa(j)-x(ir),ya(j)-y(ir),za(j)-z(ir)]/celluse;
         if norm(temp-round(temp))<0.001
            draworb(ir,lmaxuse,scale(1),CPatom_coeff(:,j),CPlobecolor,lobealpha(1),OLflag,OLcolor,OLwidth,'complex',lightparam,facelighting,resuse,'CP');
            draworb(ir,lmaxuse,scale(2),CMatom_coeff(:,j),CMlobecolor,lobealpha(2),OLflag,OLcolor,OLwidth,'complex',lightparam,facelighting,resuse,'CM');
            atomupdate(ir);
            break;
         end
      end
   end
elseif strcmpi(mode,'mixed')
   CPatom_coeff=reshape(CPcoeff,size_coeff,atomnum);
   CPatom_coeff(1:(lmaxuse+1)^2,:)=CPatom_coeff(1:(lmaxuse+1)^2,:)*scale(1);
   CPatom_coeff((lmaxuse+1)^2+1:(lmax+1)^2,:)=0;
   CMatom_coeff=reshape(CMcoeff,size_coeff,atomnum);
   CMatom_coeff(1:(lmaxuse+1)^2,:)=CMatom_coeff(1:(lmaxuse+1)^2,:)*scale(1);
   CMatom_coeff((lmaxuse+1)^2+1:(lmax+1)^2,:)=0;
   if isnumeric(lobecolor)&&numel(lobecolor)==12 CPlobecolor=lobecolor(1,:); CMlobecolor=lobecolor(2,:);
   else CPlobecolor=lobecolor; CMlobecolor=lobecolor;
   end
   for ir=sitelist
      for j=1:size(xa)
         temp=[xa(j)-x(ir),ya(j)-y(ir),za(j)-z(ir)]/celluse;
         if norm(temp-round(temp))<0.001
            orbhdl=draworb(ir,lmaxuse,scale(1),CPatom_coeff(:,j),CPlobecolor,lobealpha(1),OLflag,OLcolor,OLwidth,'complex',lightparam,facelighting,resuse,'CP');
            hdltemp=draworb(ir,lmaxuse,-1,CMatom_coeff(:,j),CMlobecolor,lobealpha(2),OLflag,OLcolor,OLwidth,'complex',lightparam,facelighting,resuse,'CP');
            rnew=hdltemp{1};CM0=hdltemp{2};
            temp=rnew<0; rnew=abs(rnew); rmax=max(max(rnew))*3;
            cmHr=zeros(size(rnew,1),size(rnew,2));cmHg=zeros(size(rnew,1),size(rnew,2));cmHb=zeros(size(rnew,1),size(rnew,2));
            cmHr(temp)=CMlobecolor(4);cmHr(~temp)=CMlobecolor(1);
            cmHg(temp)=CMlobecolor(5);cmHg(~temp)=CMlobecolor(2);
            cmHb(temp)=CMlobecolor(6);cmHb(~temp)=CMlobecolor(3);
            cmH=cat(3,cmHr,cmHg,cmHb);
            cmH0=get(orbhdl,'CData'); strarray=get(orbhdl,'DisplayName');
            set(orbhdl,'CData',repmat(rnew/rmax,[1,1,3]).*cmH+repmat((rmax-rnew)/rmax,[1,1,3]).*cmH0,'DisplayName',[strarray,', CM= ',num2str(CM0*104280/scale(1)),' GPa']);
            atomupdate(ir);
            break;
         end
      end
   end
end

function drawraMO(geoname,supercell,scales,ao_map,coeff,varargin)
global x y z res;
paramuse={'O','OW','OC','LC','LA','LP','FL','RES'};
OLwidth=0.05; OLcolor=[1,1,1]; OLflag='off'; lobecolor='default'; lightparam='default'; lobealpha=1; resuse=res;
facelighting='gouraud'; setfuncdefault(varargin,paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
[~,xa,ya,za]=textread(geoname,'%s %f %f %f');
sitelist=siteselect('all');
for ir=sitelist
   for j=1:size(xa)
      temp=[xa(j)-x(ir),ya(j)-y(ir),za(j)-z(ir)]/supercell;
      if norm(temp-round(temp))<0.01
         coeffuse=zeros(9,1);
         coeffuse(1:ao_map(j))=scales*coeff(sum(ao_map(1:j-1))+1:sum(ao_map(1:j)));
         draworb(ir,sqrt(ao_map(j))-1,scales,coeffuse,lobecolor,lobealpha,OLflag,OLcolor,OLwidth,'real',lightparam,facelighting,resuse,'raMO');
         atomupdate(ir);
         break;
      end
   end
end

function hdltemp=draworb(i,lmax,scale,coeff,colorref,lobealpha,OLflag,OLcolorref,OLwidth,RCflag,lightparam,facelighting,resuse,orbtype)
global x y z;
global aup bnorm cline;
global objlist;
if ischar(colorref)
   if strcmpi(colorref,'colored')
      poscolor=atomcolorlookup('verylight',i);
      negcolor=atomcolorlookup('verydark',i);
   elseif strcmpi(colorref,'default')
      poscolor=[0.8 0.8 0.8];
      negcolor=[0 0 0];
   end
else
   poscolor=colorref(1:3);
   negcolor=colorref(4:6);
end
if ischar(OLcolorref)
   if strcmpi(OLcolorref,'atom') OLcolor=atomcolorlookup('default',i);
   elseif strcmpi(OLcolorref,'default') OLcolor=[1 1 1];
   end
else
   OLcolor=OLcolorref;
end
[Xj,Yj,Zj]=sphere(25+15*resuse);
size0=size(Xj);
temp=[Xj(:),Yj(:),Zj(:)]*[-aup;-cline;bnorm];
Xj=reshape(temp(:,1),size0);Yj=reshape(temp(:,2),size0);Zj=reshape(temp(:,3),size0);
[phi,theta,~]=cart2sph(Xj,Yj,Zj);
if strcmpi(RCflag,'complex')
   thetaj=pi/2*ones(size(phi))-theta;
   thetaj=abs(thetaj);
   rnew=(1/(4*pi))^0.5*coeff(1)*ones(size(phi));
   counter=1;
   for l=1:lmax
      m=0;
      Plm_0=2^0.5*legendre(l,cos(thetaj),'norm');
      Plm(:,:)=(-1)^m*Plm_0(m+1,:,:);
      counter=counter+1;
      rnew=rnew+coeff(counter)*Plm/((4*pi)^0.5);
      for m=1:l
         counter=counter+2;
         Plm(:,:)=(-1)^m*Plm_0(m+1,:,:);
         rnew=rnew+Plm*2^0.5.*(coeff(counter-1)*cos(m*phi)+coeff(counter)*sin(m*phi))/((4*pi)^0.5);
      end
   end
elseif strcmpi(RCflag,'real')      % coeff=[s,px,py,pz,dx2-y2,dz2,dxy,dxz,dyz]
   rnew=coeff(1)*(1/(4*pi))^0.5*ones(size(phi));
   rnew=rnew+coeff(2)*0.5*(3/pi)^0.5*cos(theta).*cos(phi);
   rnew=rnew+coeff(3)*0.5*(3/pi)^0.5*cos(theta).*sin(phi);
   rnew=rnew+coeff(4)*0.5*(3/pi)^0.5*sin(theta);
   rnew=rnew+coeff(5)*(15/(16*pi))^0.5*cos(theta).^2.*cos(2*phi);
   rnew=rnew+coeff(6)*0.25*(5/(pi))^0.5*(3*sin(theta).^2-ones(size(theta)));
   rnew=rnew+coeff(7)*(15/(16*pi))^0.5*cos(theta).^2.*sin(2*phi);
   rnew=rnew+coeff(8)*0.5*(15/(pi))^0.5*(sin(theta).*cos(theta).*cos(phi));
   rnew=rnew+coeff(9)*0.5*(15/(pi))^0.5*(sin(theta).*cos(theta).*sin(phi));
end
if scale==-1 hdltemp={rnew,coeff(1)}; return; end
[Xnew,Ynew,Znew]=sph2cart(phi,theta,abs(rnew));
Xnew=Xnew+x(i);
Ynew=Ynew+y(i);
Znew=Znew+z(i);
cmH=zeros(numel(rnew),3); temp=rnew<0; stemp=sum(sum(temp));
cmH(temp,:)= repmat(negcolor,stemp,1); cmH(~temp,:)= repmat(poscolor,numel(rnew)-stemp,1); cmH=reshape(cmH,[size(rnew,1),size(rnew,2),3]);
if strcmpi(orbtype,'CP') strarray=[atominfo(i),' CP= ',num2str(coeff(1)*104280/scale),' GPa'];
elseif strcmpi(orbtype,'CM') strarray=[atominfo(i),' CM= ',num2str(coeff(1)*104280/scale),' GPa'];
elseif strcmpi(orbtype,'raMO') strarray=atominfo(i);
end
hdltemp=surf(Xnew,Ynew,Znew,'FaceLighting',facelighting,'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),...
   'SpecularExponent',lightparam(4),'EdgeColor','none','FaceAlpha',lobealpha,'AlphaDataMapping','none','CData',cmH,'DisplayName',strarray);
objlist(end+1,1:3)={hdltemp,'lobe',i};
if strcmpi(OLflag,'on')
   res0=25+15*resuse;
   [rmax0,ind0]=max(bsxfun(@times,abs(rnew),cos(-pi/2:pi/res0:pi/2)'));
   theta=0:2*pi/res0:2*pi;
   peri0=bsxfun(@plus,[x(i),y(i),z(i)]',bsxfun(@times,aup'*cos(theta)+cline'*sin(theta),rmax0));
   for i=1:size(peri0,2)
      peri0(:,i)=peri0(:,i)-dot(peri0(:,i)-[Xnew(ind0(i),i),Ynew(ind0(i),i),Znew(ind0(i),i)]',bnorm')*bnorm';
   end
   peri3=[peri0(:,2:size(peri0,2)),peri0(:,2)];
   temp=zeros(size(peri0));
   for i=1:size(temp,2)
      temp(:,i)=cross(peri3(:,i)-peri0(:,i),bnorm);
      temp(:,i)=temp(:,i)/norm(temp(:,i))*OLwidth;
   end
   peri1=peri0-temp;
   peri2=[peri1(:,2:size(peri1,2)),peri1(:,1)];
   cylX=[peri0(1,:);peri1(1,:);peri2(1,:);peri3(1,:)];
   cylY=[peri0(2,:);peri1(2,:);peri2(2,:);peri3(2,:)];
   cylZ=[peri0(3,:);peri1(3,:);peri2(3,:);peri3(3,:)];
   surf(cylX,cylY,cylZ,'FaceColor',OLcolor,'FaceLighting','none','LineStyle','none');
end

function drawsurface(varargin)
global unitcell res objlist xsfgrid;
paramuse={'RN','CT','FA','FC','FL','LP','RES','FCR','FCM','SM','SMS','SMD'};
funchdl=varargin{1}; isovalue=varargin{2}; range=[0,1,0,1,0,1]; coordtype='direct'; facecolor=[0.5,0.5,0.5]; facealpha=1; resuse='default'; facecolorrange='default';
facecolormap='hsv'; facelighting='gouraud'; lightparam='default'; smoothflag='off'; smoothsize=3; smoothdev=0.65;
setfuncdefault(varargin(3:end),paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
if ischar(resuse)&&strcmpi(resuse,'default'), if ischar(facecolor)&&strcmpi(facecolor,'xsf') resuse=res+10; else resuse=res; end, end
if strcmpi(coordtype,'direct')
   [xr,yr,zr]=meshgrid(range(1):1/((resuse+5)*norm(unitcell(1,:))):range(2),range(3):1/((resuse+5)*norm(unitcell(2,:))):range(4),range(5):1/((resuse+5)*norm(unitcell(3,:))):range(6));
   xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]);
   size0=size(xr); temp=[xr(:),yr(:),zr(:)]*unitcell; xr=reshape(temp(:,1),size0); yr=reshape(temp(:,2),size0); zr=reshape(temp(:,3),size0); fvalue=funchdl(xr,yr,zr);
   [x0,y0,z0]=meshgrid(range(1:2),range(3:4),range(5:6)); corners=[x0(:),y0(:),z0(:)]*unitcell;
elseif strcmpi(coordtype,'Cartesian') [xr,yr,zr]=meshgrid(range(1):1/(resuse+5):range(2),range(3):1/(resuse+5):range(4),range(5):1/(resuse+5):range(6));
   xr=permute(xr,[2,1,3]);yr=permute(yr,[2,1,3]);zr=permute(zr,[2,1,3]);
   fvalue=funchdl(xr,yr,zr); [x0,y0,z0]=meshgrid(range(1:2),range(3:4),range(5:6)); corners=[x0(:),y0(:),z0(:)];
end
if strcmpi(smoothflag,'on') fvalue=smooth3(fvalue,'gaussian',smoothsize,smoothdev); end
fv=isosurface(xr,yr,zr,fvalue,isovalue);fighdl=patch(fv);
set(fighdl,'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,'AmbientStrength',lightparam(1),...
   'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
if isnumeric(facecolor) set(fighdl,'FaceColor',facecolor);
elseif ~isempty(fv.vertices)&&ischar(facecolor)&&strcmpi(facecolor,'xsf')
   if isempty(xsfgrid) readXSF(); end
   if ischar(facecolorrange)&&strcmpi(facecolorrange,'default') facecolorrange=[xsfgrid{5},xsfgrid{6}]; end
   if isnumeric(facecolormap) cm0=(0:1/256:1)'*facecolormap(4:6)+(1:-1/256:0)'*facecolormap(1:3);
   elseif ischar(facecolormap)
      if strcmpi(facecolormap,'hsv') cm0=colormap(hsv(384));cm0=cm0(1:257,:);
      elseif ismember(facecolormap,{'gray','grey'}) cm0=flipud(colormap(gray(257)));
      end
   end
   temp=fv.vertices/unitcell;temp=temp-floor(temp);
   [xtemp,ytemp,ztemp]=meshgrid(0:1/(xsfgrid{1}-1):1,0:1/(xsfgrid{2}-1):1,0:1/(xsfgrid{3}-1):1);
   fvf=interp3(xtemp,ytemp,ztemp,permute(xsfgrid{4},[2,1,3]),temp(:,1),temp(:,2),temp(:,3));
   cmind=round(((facecolorrange(2)-fvf)+(fvf-facecolorrange(1))*257)/(facecolorrange(2)-facecolorrange(1)));
   cmind=min(max(cmind,1),257);
   cmH=cm0(cmind,:);
   set(fighdl,'FaceVertexCData',cmH,'FaceColor','interp');
end
boundupdatex(corners);
objlist(end+1,1:3)={fighdl,'surf',[]};

function drawplane(varargin)
global x y z unitcell;
coord=varargin{1};coordtype=varargin{2};
if strcmpi(coordtype,'atom') coord=[x(coord),y(coord),z(coord)];
elseif strcmpi(coordtype,'direct') coord=coord*unitcell;
end
vnorm=cross(coord(2,:)-coord(1,:),coord(3,:)-coord(1,:));
if abs(vnorm)<0.001 error('Cannot accept colinear atomic coordinates!'); end
func=@(x,y,z) vnorm(1)*(x-coord(1,1))+vnorm(2)*(y-coord(1,2))+vnorm(3)*(z-coord(1,3));
drawsurface(func,0,varargin{3:end},'CT','direct','FL','none');

function drawmiller(varargin)
global x y z unitcell;
hkl=varargin{1};millertype=varargin{2};dist0=varargin{3};
if norm(hkl)==0 error('Miller indices cannot be all zero!'); end
if hkl(1)~=0 vnorm=cross(hkl(1)*unitcell(2,:)-hkl(2)*unitcell(1,:),hkl(1)*unitcell(3,:)-hkl(3)*unitcell(1,:));
elseif hkl(2)~=0 vnorm=cross(hkl(2)*unitcell(3,:)-hkl(3)*unitcell(2,:),hkl(2)*unitcell(1,:)-hkl(1)*unitcell(2,:));
elseif hkl(3)~=0 vnorm=cross(hkl(3)*unitcell(1,:)-hkl(1)*unitcell(3,:),hkl(3)*unitcell(2,:)-hkl(2)*unitcell(3,:));
end
if strcmpi(millertype,'direct') point0=dist0*unitcell;
elseif strcmpi(millertype,'atom') point0=[x(dist0),y(dist0),z(dist0)];
elseif strcmpi(millertype,'distc') point0=dist0*sign(hkl)*unitcell;
elseif strcmpi(millertype,'distr') point0=vnorm/norm(vnorm)*dist0;
elseif strcmpi(millertype,'Cartesian') point0=dist0;
end
func=@(x,y,z) vnorm(1)*(x-point0(1))+vnorm(2)*(y-point0(2))+vnorm(3)*(z-point0(3));
drawsurface(func,0,varargin{4:end},'CT','direct','FL','none');

function drawMO(varargin)
global aup bnorm cline MOdata;
global x y z;
global objlist unitcell res;
paramuse={'CS','D','LA','LC','FL','LP','RES'};
aolist=varargin{1};isovalue=varargin{2};coordset='cell';dist=2;lobealpha=1;lobecolor='default';facelighting='gouraud';lightparam='default';
resuse=res; setfuncdefault(varargin(3:end),paramuse); lightparam=getlightparam(lightparam,[0.8,0.6,0.9,10]);
if ~iscell(aolist), if isempty(MOdata) readMO(); end, aolist=MOdata{aolist}; MOtype='file'; else MOtype='user'; end
aolist=aolist(abs([aolist{:,3}])>0.0001,:); sitelist=unique([aolist{:,1}]');
if ischar(lobecolor)&&strcmpi(lobecolor,'default') lobecolor=[0.8,0.8,0.8,0,0,0];
elseif ischar(lobecolor)&&strcmpi(lobecolor,'colored') lobecolor=[mean(atomcolorlookup('verylight',sitelist),1),mean(atomcolorlookup('verydark',sitelist),1)];
end
[xr0,yr0,zr0]=meshgrid(min(x(sitelist))-dist:0.5/(resuse+5):max(x(sitelist))+dist,min(y(sitelist))-dist:0.5/(resuse+5):max(y(sitelist))+dist,...
   min(z(sitelist))-dist:0.5/(resuse+5):max(z(sitelist))+dist);
fvalue=zeros(size(xr0));
if strcmp(MOtype,'file') coordset=eye(3);
else
   if ischar(coordset)&&strcmpi(coordset,'view') coordset=[bnorm;cline;aup];
   elseif ischar(coordset)&&strcmpi(coordset,'cell') [qtemp,~]=qr(unitcell'); coordset=qtemp';
   elseif ischar(coordset)&&strcmpi(coordset,'fit')
      xyzlist=[x(sitelist),y(sitelist),z(sitelist)]; vnorm=fitsuperplane(xyzlist); orientnew=[vnorm',null(vnorm)]'; xyznew=xyzlist/orientnew;
      unorm=[0,fitsuperplane(xyznew(:,2:3))]*orientnew; unorm=unorm/norm(unorm); wnorm=cross(unorm,vnorm); coordset=[wnorm;unorm;vnorm];
   end
end
for k=1:size(aolist,1)
   x0=x(aolist{k,1});y0=y(aolist{k,1});z0=z(aolist{k,1});temp=[xr0(:)-x0,yr0(:)-y0,zr0(:)-z0]/coordset;
   xr=reshape(temp(:,1),size(xr0));yr=reshape(temp(:,2),size(xr0));zr=reshape(temp(:,3),size(xr0));r0=(xr.^2+yr.^2+zr.^2).^0.5+0.000001;
   if size(aolist,2)==3 frad=2*exp(-r0); orbtype=aolist{k,2};
   else qn=str2double(aolist{k,2}(1)); orbtype=aolist{k,2}(2:end);
      if aolist{k,5}==0 frad=(2*aolist{k,4})^qn*sqrt(2*aolist{k,4}/factorial(2*qn))*r0.^(qn-1).*exp(-aolist{k,4}*r0);
      else frad=((2*aolist{k,4})^qn*sqrt(2*aolist{k,4}/factorial(2*qn))*r0.^(qn-1).*exp(-aolist{k,4}*r0)*aolist{k,5}+...
            (2*aolist{k,6})^qn*sqrt(2*aolist{k,6}/factorial(2*qn))*r0.^(qn-1).*exp(-aolist{k,6}*r0)*aolist{k,7});
      end
   end
   switch orbtype
      case 's', fvalue=fvalue+frad*aolist{k,3};
      case 'px', fvalue=fvalue+xr./r0.*frad*(aolist{k,3}*sqrt(3));
      case 'py', fvalue=fvalue+yr./r0.*frad*(aolist{k,3}*sqrt(3));
      case 'pz', fvalue=fvalue+zr./r0.*frad*(aolist{k,3}*sqrt(3));
      case 'dx2-y2', fvalue=fvalue+(xr.^2-yr.^2)./(r0.^2).*frad*(aolist{k,3}*sqrt(15/4));
      case 'dz2', fvalue=fvalue+(2*zr.^2-xr.^2-yr.^2)./(r0.^2).*frad*(aolist{k,3}*sqrt(5/4));
      case 'dxy', fvalue=fvalue+xr.*yr./(r0.^2).*frad*(aolist{k,3}*sqrt(15));
      case 'dxz', fvalue=fvalue+xr.*zr./(r0.^2).*frad*(aolist{k,3}*sqrt(15));
      case 'dyz', fvalue=fvalue+yr.*zr./(r0.^2).*frad*(aolist{k,3}*sqrt(15));
      case 'fx3', fvalue=fvalue+xr.*(5*xr.^2-3*r0.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(7/4));
      case 'fy3', fvalue=fvalue+yr.*(5*yr.^2-3*r0.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(7/4));
      case 'fz3', fvalue=fvalue+zr.*(5*zr.^2-3*r0.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(7/4));
      case 'fx(z2-y2)', fvalue=fvalue+xr.*(zr.^2-yr.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(105/4));
      case 'fy(z2-x2)', fvalue=fvalue+yr.*(zr.^2-xr.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(105/4));
      case 'fz(x2-y2)', fvalue=fvalue+zr.*(xr.^2-yr.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(105/4));
      case 'fxyz', fvalue=fvalue+xr.*yr.*zr./(r0.^3).*frad*(aolist{k,3}*sqrt(105));
      case 'fxz2', fvalue=fvalue+xr.*(5*zr.^2-r0.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(21/8));
      case 'fyz2', fvalue=fvalue+yr.*(5*zr.^2-r0.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(21/8));
      case 'fy(3x2-y2)', fvalue=fvalue+yr.*(3*xr.^2-yr.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(35/8));
      case 'fx(x2-3y2)', fvalue=fvalue+xr.*(xr.^2-3*yr.^2)./(r0.^3).*frad*(aolist{k,3}*sqrt(35/8));
      otherwise error(['Unrecognized atomic orbital ''',aolist{k,2},'''!']);
   end
end
fighdl=patch(isosurface(xr0,yr0,zr0,fvalue/sqrt(4*pi),sqrt(isovalue)));
set(fighdl,'FaceColor',lobecolor(1:3),'FaceAlpha',lobealpha,'LineStyle','none','FaceLighting',facelighting,'AmbientStrength',lightparam(1),...
   'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
objlist(end+1,1:3)={fighdl,'surf',[]};
fighdl=patch(isosurface(xr0,yr0,zr0,fvalue/sqrt(4*pi),-sqrt(isovalue)));
set(fighdl,'FaceColor',lobecolor(4:6),'FaceAlpha',lobealpha,'LineStyle','none','FaceLighting',facelighting,'AmbientStrength',lightparam(1),...
   'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
objlist(end+1,1:3)={fighdl,'surf',[]};
[xc,yc,zc]=meshgrid([min(x(sitelist))-dist,max(x(sitelist))+dist],[min(y(sitelist))-dist,max(y(sitelist))+dist],[min(z(sitelist))-dist,max(z(sitelist))+dist]);
boundupdatex([xc(:),yc(:),zc(:)]);

function insertfigure(varargin)
global x y z unitcell objlist;
paramuse={'FA','FL','LP'};
filename=varargin{1};postype=varargin{2};figpos=varargin{3};facealpha=1;facelighting='flat';lightparam='default';
setfuncdefault(varargin(4:end),paramuse); lightparam=getlightparam(lightparam,[1,0.6,0.9,1]);
figdata=imread(filename);
if strcmpi(postype,'direct') figpos=figpos*unitcell;
elseif strcmpi(postype,'atom') figpos=[x(figpos),y(figpos),z(figpos)];
elseif strcmpi(postype,'centerat') figpos=[figpos{1}-figpos{2}+figpos{3};figpos{1}+figpos{2}+figpos{3};figpos{1}-figpos{2}-figpos{3};figpos{1}+figpos{2}-figpos{3}];
end
xdata=reshape(figpos(:,1),2,2)'; ydata=reshape(figpos(:,2),2,2)'; zdata=reshape(figpos(:,3),2,2)';
fighdl=surf(xdata,ydata,zdata,'FaceColor','TextureMap','CData',figdata,'FaceAlpha',facealpha,'LineStyle','none','FaceLighting',facelighting,...
   'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),'SpecularExponent',lightparam(4));
objlist(end+1,1:3)={fighdl,'surf',[]};
boundupdatex(figpos);

function drawgreenline(varargin)
global aup bnorm cline;
global imgbound;
paramuse={'D'};
if isequal(imgbound,[1000,1000,1000,-1000,-1000,-1000]) imgbound=[0,0,0,0,0,0]; end
dist=1; setfuncdefault(varargin,paramuse);
point0=[imgbound(1)-dist,0,0.5*(imgbound(3)+imgbound(6))]*[aup;bnorm;cline];
point1=point0-1.5*cline;
point2=point0+1.5*cline;
line([point1(1),point2(1)],[point1(2),point2(2)],[point1(3),point2(3)],'Color','g','LineWidth',6);
boundupdatex([point1;point2]);

function drawboundbox(varargin)
global aup bnorm cline;
global imgbound;
paramuse={'D','IB'};
if isequal(imgbound,[1000,1000,1000,-1000,-1000,-1000]) imgbound=[0,0,0,0,0,0]; end
dist=1; bounduse=imgbound; setfuncdefault(varargin,paramuse);
corner=[bounduse(1)-dist,0,bounduse(3)-dist;bounduse(1)-dist,0,bounduse(6)+dist;bounduse(4)+dist,0,bounduse(3)-dist;bounduse(4)+dist,0,bounduse(6)+dist];
cornerx=corner*[aup;bnorm;cline];
line([cornerx(1,1),cornerx(2,1)],[cornerx(1,2),cornerx(2,2)],[cornerx(1,3),cornerx(2,3)],'Color',[0 0 0],'LineWidth',1);
line([cornerx(3,1),cornerx(4,1)],[cornerx(3,2),cornerx(4,2)],[cornerx(3,3),cornerx(4,3)],'Color',[0 0 0],'LineWidth',1);
line([cornerx(1,1),cornerx(3,1)],[cornerx(1,2),cornerx(3,2)],[cornerx(1,3),cornerx(3,3)],'Color',[0 0 0],'LineWidth',1);
line([cornerx(2,1),cornerx(4,1)],[cornerx(2,2),cornerx(4,2)],[cornerx(2,3),cornerx(4,3)],'Color',[0 0 0],'LineWidth',1);
boundupdatex(cornerx);

function drawcoordsystem(varargin)
global aup bnorm cline;
global imgbound unitcell;
paramuse={'D','T','SC'};
if isequal(imgbound,[1000,1000,1000,-1000,-1000,-1000]) imgbound=[0,0,0,0,0,0]; end
p=[0.25,0.15]; ltype='cylinder'; ang=15; scale=1; textflag='on'; dist=1.5; setfuncdefault(varargin,paramuse);
cellmatrix=zeros(3);
cellmatrix1=zeros(3);
if abs(det(unitcell))<0.001 error('Wrong cell vectors!'); end
for i=1:3
   cellmatrix(i,:)=unitcell(i,:)/norm(unitcell(i,:))*scale;
end
for i=1:3
   temp=cellmatrix(i,:)-dot(cellmatrix(i,:),bnorm)*bnorm;
   if norm(temp)~=0 cellmatrix1(i,:)=cellmatrix(i,:)+0.15*temp/norm(temp);
   else cellmatrix1(i,:)=cellmatrix(i,:)-0.15*cline;
   end
end
point0=[imgbound(4)-0.5*dist,0,imgbound(3)-dist]*[aup;bnorm;cline];
startx=[point0;point0;point0];
endx=startx+cellmatrix;
endx1=startx+cellmatrix1;
arrow3d(startx,endx,ang/180*pi,ltype,p,[30,30]);
if strcmpi(textflag,'on')
   text(endx1(1,1),endx1(1,2),endx1(1,3),'a','HorizontalAlignment','center');
   text(endx1(2,1),endx1(2,2),endx1(2,3),'b','HorizontalAlignment','center');
   text(endx1(3,1),endx1(3,2),endx1(3,3),'c','HorizontalAlignment','center');
end
boundupdatex(point0);













