%% ========================================================================
%  RESPONSE SURFACE METHODOLOGY (RSM) + ANOVA
%  Computationally Optimised Stiffened Panels under Compressive Loading
%  ------------------------------------------------------------------------
%  Linear (eigenvalue) buckling results for a 3x3x3 full-factorial design:
%       skin thickness     t = {2, 3, 4} mm
%       stiffener height   h = {25, 35, 45} mm
%       stiffener spacing  b = {100, 150, 200} mm
%
%  This script:
%    1. Loads the 27-run dataset (embedded - fully reproducible)
%    2. Fits full quadratic response surfaces for  P_cr,  Mass,  P_cr/Mass
%    3. Runs ANOVA on each model (F-tests, p-values, R^2, adjusted R^2)
%    4. Checks model adequacy (predicted-vs-actual, residual diagnostics)
%    5. Plots 3-D response surfaces and 2-D contour maps
%    6. Performs multi-objective optimisation (maximise strength-to-weight)
%    7. Writes a results summary to file
%
%  Requirements: MATLAB + Statistics and Machine Learning Toolbox
%  Run:  place this file in any folder and press Run (F5).
%  ========================================================================

clear; clc; close all;
outdir = fullfile(pwd,'RSM_ANOVA_Results');
if ~exist(outdir,'dir'); mkdir(outdir); end
diary(fullfile(outdir,'RSM_ANOVA_log.txt')); diary on;

%% ----- 0. USER SETTING --------------------------------------------------
% Eigenvalue buckling returns a load multiplier (lambda). The critical load
% is  P_cr = lambda * (reference force).  The reference force used in the
% ANSYS Static Structural step was 1000 N, so P_cr [kN] = lambda.
% If a different reference force was used, change ONLY this value.
REF_FORCE_N = 1000;          % reference compressive force applied in ANSYS [N]

%% ----- 1. DATASET (27 runs) ---------------------------------------------
% Columns: Panel | t(mm) | h(mm) | b(mm) | lambda1 | Mass(kg)
% lambda1 = first (critical) eigenvalue / load multiplier from ANSYS.
data = [
 1   2  25  100   218.900   4.9140
 2   2  25  150    86.234   4.2444
 3   2  25  200    44.824   3.9096
 4   2  35  100   227.030   5.1840
 5   2  35  150    88.167   4.4064
 6   2  35  200    45.595   4.0176
 7   2  45  100   235.380   5.4540
 8   2  45  150    90.200   4.5684
 9   2  45  200    46.288   4.1256
 10  3  25  100   341.350   6.5475
 11  3  25  150   243.010   5.8725
 12  3  25  200   131.190   5.5350
 13  3  35  100   644.780   6.8175
 14  3  35  150   255.520   6.0345
 15  3  35  200   132.400   5.6430
 16  3  45  100   603.670   7.0875
 17  3  45  150   259.340   6.1965
 18  3  45  200   133.270   5.7510
 19  4  25  100   396.840   8.1810
 20  4  25  150   286.850   7.5006
 21  4  25  200   224.420   7.1604
 22  4  35  100   745.380   8.4510
 23  4  35  150   528.500   7.6626
 24  4  35  200   284.780   7.2684
 25  4  45  100   655.900   8.7210
 26  4  45  150   540.130   7.8246
 27  4  45  200   286.600   7.3764
];

Panel = data(:,1);
t     = data(:,2);          % skin thickness          [mm]
h     = data(:,3);          % stiffener height        [mm]
b     = data(:,4);          % stiffener spacing       [mm]
lam   = data(:,5);          % first eigenvalue        [-]
Mass  = data(:,6);          % panel mass              [kg]

Pcr   = lam * REF_FORCE_N / 1000;     % critical buckling load  [kN]
Ratio = Pcr ./ Mass;                  % strength-to-weight      [kN/kg]

% ---- Coded (normalised) factors: maps {lo,mid,hi} -> {-1,0,+1} ----------
% Standard RSM practice - makes regression coefficients directly comparable.
T = (t - 3) / 1;            % t: 2,3,4   -> -1,0,+1
H = (h - 35) / 10;          % h:25,35,45 -> -1,0,+1
B = (b - 150) / 50;         % b:100,150,200 -> -1,0,+1

tbl = table(T,H,B,Pcr,Mass,Ratio);

fprintf('==============================================================\n');
fprintf(' STIFFENED PANEL - RSM / ANOVA   (%d runs, 3x3x3 full factorial)\n',height(tbl));
fprintf('==============================================================\n');
fprintf(' Reference force assumed         : %d N\n',REF_FORCE_N);
fprintf(' P_cr   range : %7.1f - %7.1f kN\n',min(Pcr),max(Pcr));
fprintf(' Mass   range : %7.2f - %7.2f kg\n',min(Mass),max(Mass));
fprintf(' P/M    range : %7.1f - %7.1f kN/kg\n\n',min(Ratio),max(Ratio));

%% ----- 2. FIT FULL QUADRATIC RESPONSE SURFACES --------------------------
% 'quadratic' = intercept + linear + 2-way interactions + squared terms
mdlPcr   = fitlm(tbl,'quadratic','ResponseVar','Pcr', ...
                 'PredictorVars',{'T','H','B'});
mdlMass  = fitlm(tbl,'quadratic','ResponseVar','Mass', ...
                 'PredictorVars',{'T','H','B'});
mdlRatio = fitlm(tbl,'quadratic','ResponseVar','Ratio', ...
                 'PredictorVars',{'T','H','B'});

%% ----- 3. ANOVA + MODEL SUMMARY -----------------------------------------
report_model('P_cr  (critical buckling load, kN)', mdlPcr);
report_model('Mass  (panel mass, kg)',             mdlMass);
report_model('P_cr / Mass  (strength-to-weight, kN/kg)', mdlRatio);

% ---- Reduced models (keep only terms significant at p < 0.05) -----------
fprintf('\n--- REDUCED MODELS (significant terms only, p < 0.05) ---\n');
mdlPcr_r   = reduce_model(tbl,'Pcr');
mdlMass_r  = reduce_model(tbl,'Mass');
mdlRatio_r = reduce_model(tbl,'Ratio');

%% ----- 4. REGRESSION EQUATIONS (coded and actual units) -----------------
fprintf('\n=== FITTED RSM EQUATIONS (full quadratic, coded factors) ===\n');
print_coded_eqn('P_cr', mdlPcr);
print_coded_eqn('Mass', mdlMass);
print_coded_eqn('Ratio', mdlRatio);

%% ----- 5. MODEL ADEQUACY: predicted vs actual + residuals ---------------
adequacy_plots(mdlPcr ,'P_{cr} (kN)'        ,outdir,'adequacy_Pcr');
adequacy_plots(mdlMass ,'Mass (kg)'         ,outdir,'adequacy_Mass');
adequacy_plots(mdlRatio,'P_{cr}/Mass (kN/kg)',outdir,'adequacy_Ratio');

%% ----- 6. RESPONSE SURFACES + CONTOUR PLOTS -----------------------------
% P_cr surfaces
surf_contour(mdlPcr,'P_{cr} (kN)',outdir,'surface_Pcr');
% Strength-to-weight surfaces (the optimisation objective)
surf_contour(mdlRatio,'P_{cr}/Mass (kN/kg)',outdir,'surface_Ratio');

%% ----- 7. MULTI-OBJECTIVE OPTIMISATION ----------------------------------
% Goal: maximise strength-to-weight ratio P_cr/Mass over the design space
% (this is the thesis objective). Done two ways:
%   (a) best of the 27 actual simulated runs
%   (b) RSM-predicted optimum on a fine grid inside the design box
fprintf('\n==============================================================\n');
fprintf(' MULTI-OBJECTIVE OPTIMISATION  (maximise P_cr / Mass)\n');
fprintf('==============================================================\n');

% (a) best actual run
[~,iBest] = max(Ratio);
fprintf('\n(a) Best of the 27 simulated panels:\n');
fprintf('    Panel %d : t=%g mm, h=%g mm, b=%g mm\n',Panel(iBest),t(iBest),h(iBest),b(iBest));
fprintf('              P_cr = %.1f kN, Mass = %.3f kg, P/M = %.2f kN/kg\n',...
        Pcr(iBest),Mass(iBest),Ratio(iBest));

% (b) RSM-predicted optimum on a fine grid
ng = 61;
tg = linspace(2,4,ng); hg = linspace(25,45,ng); bg = linspace(100,200,ng);
[TT,HH,BB] = ndgrid((tg-3)/1,(hg-35)/10,(bg-150)/50);
gridTbl = table(TT(:),HH(:),BB(:),'VariableNames',{'T','H','B'});
Rr = predict(mdlRatio,gridTbl);
Pp = predict(mdlPcr ,gridTbl);
Mm = predict(mdlMass ,gridTbl);
[ratOpt,iOpt] = max(Rr);
tOpt = TT(iOpt)*1+3; hOpt = HH(iOpt)*10+35; bOpt = BB(iOpt)*50+150;
fprintf('\n(b) RSM-predicted optimum (fine grid inside design space):\n');
fprintf('    t = %.2f mm, h = %.2f mm, b = %.1f mm\n',tOpt,hOpt,bOpt);
fprintf('    Predicted P_cr = %.1f kN, Mass = %.3f kg, P/M = %.2f kN/kg\n',...
        Pp(iOpt),Mm(iOpt),ratOpt);

% Pareto front: maximise P_cr, minimise Mass (non-dominated runs)
isDom = false(27,1);
for i=1:27
  isDom(i) = any( (Pcr>=Pcr(i)) & (Mass<=Mass(i)) & ((Pcr>Pcr(i))|(Mass<Mass(i))) );
end
pareto = find(~isDom);
fprintf('\n(c) Pareto-optimal panels (max P_cr / min Mass trade-off): %s\n',...
        num2str(Panel(pareto)'));

% Pareto plot
figure('Color','w','Position',[100 100 640 460]);
scatter(Mass,Pcr,55,Ratio,'filled'); hold on;
[~,o]=sort(Mass(pareto)); pp=pareto(o);
plot(Mass(pp),Pcr(pp),'r-o','LineWidth',1.6,'MarkerFaceColor','r');
text(Mass(iBest),Pcr(iBest),sprintf('  Panel %d (best P/M)',Panel(iBest)),'FontWeight','bold');
cb=colorbar; cb.Label.String='P_{cr}/Mass (kN/kg)';
xlabel('Mass (kg)'); ylabel('P_{cr} (kN)');
title('Design space & Pareto front (maximise P_{cr}, minimise Mass)');
grid on; saveas(gcf,fullfile(outdir,'pareto_front.png'));

%% ----- 8. EXPORT CLEAN DATA + PREDICTIONS -------------------------------
out = table(Panel,t,h,b,lam,Pcr,Mass,Ratio, ...
            predict(mdlPcr,tbl), predict(mdlMass,tbl), predict(mdlRatio,tbl), ...
   'VariableNames',{'Panel','t_mm','h_mm','b_mm','lambda1','Pcr_kN','Mass_kg', ...
                    'Ratio_kN_per_kg','Pcr_fit','Mass_fit','Ratio_fit'});
writetable(out,fullfile(outdir,'RSM_dataset_and_fit.csv'));

fprintf('\n--------------------------------------------------------------\n');
fprintf(' All outputs written to:  %s\n',outdir);
fprintf('   RSM_ANOVA_log.txt          - full console log\n');
fprintf('   RSM_dataset_and_fit.csv    - data + fitted values\n');
fprintf('   adequacy_*.png             - predicted-vs-actual & residuals\n');
fprintf('   surface_*.png              - 3-D response surfaces + contours\n');
fprintf('   pareto_front.png           - optimisation trade-off plot\n');
fprintf('--------------------------------------------------------------\n');
diary off;


%% ======================================================================
%  LOCAL FUNCTIONS
%  ======================================================================
function report_model(name,mdl)
% Print ANOVA table + key fit statistics for a fitted model.
    fprintf('\n==============================================================\n');
    fprintf(' RESPONSE: %s\n',name);
    fprintf('==============================================================\n');
    aov = anova(mdl);                       % component (Type II) ANOVA
    disp(aov);
    fprintf(' R-squared            : %.4f\n',mdl.Rsquared.Ordinary);
    fprintf(' Adjusted R-squared   : %.4f\n',mdl.Rsquared.Adjusted);
    fprintf(' RMSE                 : %.4g\n',mdl.RMSE);
    fprintf(' Overall model p-value: %.3g\n',coefTest(mdl));   % F-test: all slopes = 0
    % significant terms
    sig = aov.Properties.RowNames(aov.pValue < 0.05 & ~strcmp(aov.Properties.RowNames,'Error'));
    if isempty(sig); sig = {'(none)'}; end
    fprintf(' Significant terms (p<0.05): %s\n',strjoin(sig,', '));
end

function mdl = reduce_model(tbl,resp)
% Backward elimination: start from the full quadratic, drop the least
% significant term until all remaining terms have p < 0.05. Rebuilt from an
% explicit formula each step so it is independent of term-name parsing.
    terms = {'T','H','B','T^2','H^2','B^2','T:H','T:B','H:B'};
    while true
        f   = [resp ' ~ ' strjoin(terms,' + ')];
        mdl = fitlm(tbl,f);
        aov = anova(mdl);
        nm  = aov.Properties.RowNames;
        keep = ~strcmp(nm,'Error');
        p = aov.pValue(keep); nm = nm(keep);
        [pmax,j] = max(p);
        if pmax < 0.05 || numel(terms) <= 1, break; end
        terms(strcmp(terms,nm{j})) = [];     % drop least-significant term
    end
    fprintf('  %-6s reduced model: R2=%.4f  adjR2=%.4f  terms kept: %s\n',...
        resp,mdl.Rsquared.Ordinary,mdl.Rsquared.Adjusted,strjoin(terms,', '));
end

function print_coded_eqn(name,mdl)
% Print the fitted polynomial in coded factors T,H,B.
    c  = mdl.Coefficients.Estimate;
    nm = mdl.CoefficientNames;
    s  = sprintf('  %s = %.4g',name,c(1));
    for k=2:numel(c)
        term = strrep(nm{k},':','*');
        s = [s sprintf(' %+.4g*%s',c(k),term)]; %#ok<AGROW>
    end
    fprintf('%s\n',s);
    fprintf('     (coded: T=(t-3)/1, H=(h-35)/10, B=(b-150)/50)\n');
end

function adequacy_plots(mdl,lbl,outdir,fname)
% Predicted-vs-actual and residual diagnostic plots.
    y  = mdl.Variables.(mdl.ResponseName);
    yh = predict(mdl);
    r  = mdl.Residuals.Standardized;
    figure('Color','w','Position',[80 80 980 320]);

    subplot(1,3,1);
    plot(y,yh,'o','MarkerFaceColor',[.2 .4 .8]); hold on;
    lim=[min([y;yh]) max([y;yh])]; plot(lim,lim,'k--');
    xlabel(['Actual ' lbl]); ylabel(['Predicted ' lbl]);
    title(sprintf('Predicted vs Actual  (R^2=%.3f)',mdl.Rsquared.Ordinary));
    axis equal tight; grid on;

    subplot(1,3,2);
    plot(yh,r,'o','MarkerFaceColor',[.2 .4 .8]); yline(0,'k--');
    yline(2,'r:'); yline(-2,'r:');
    xlabel(['Predicted ' lbl]); ylabel('Standardised residual');
    title('Residuals vs Fitted'); grid on;

    subplot(1,3,3);
    qqplot(r); title('Normal Q-Q of residuals'); grid on;

    sgtitle(['Model adequacy - ' lbl]);
    saveas(gcf,fullfile(outdir,[fname '.png']));
end

function surf_contour(mdl,lbl,outdir,fname)
% 3-D response surfaces and 2-D contour maps on the three coordinate
% planes, each with the third factor held at its mid-level (coded 0).
    ng = 41;
    g  = linspace(-1,1,ng);
    pairs = {'T','H', 'b held at 150 mm'; ...
             'T','B', 'h held at 35 mm' ; ...
             'H','B', 't held at 3 mm'  };
    ax = {'t (mm)','h (mm)','b (mm)'};
    code2real = @(v,which) (strcmp(which,'T')).*(v*1+3) + ...
                           (strcmp(which,'H')).*(v*10+35) + ...
                           (strcmp(which,'B')).*(v*50+150);

    figure('Color','w','Position',[60 60 1180 720]);
    for k=1:3
        v1=pairs{k,1}; v2=pairs{k,2};
        [G1,G2]=meshgrid(g,g);
        P.T=zeros(size(G1)); P.H=zeros(size(G1)); P.B=zeros(size(G1));
        P.(v1)=G1; P.(v2)=G2;
        Z = reshape(predict(mdl,table(P.T(:),P.H(:),P.B(:),...
              'VariableNames',{'T','H','B'})),size(G1));
        R1 = code2real(G1,v1); R2 = code2real(G2,v2);
        ax1 = ax{strcmp({'T','H','B'},v1)};
        ax2 = ax{strcmp({'T','H','B'},v2)};

        subplot(2,3,k);
        surf(R1,R2,Z); shading interp; colormap(parula);
        xlabel(ax1); ylabel(ax2); zlabel(lbl);
        title(['Surface: ' lbl '   (' pairs{k,3} ')']);
        view(-37,30); grid on;

        subplot(2,3,k+3);
        contourf(R1,R2,Z,12); colorbar;
        xlabel(ax1); ylabel(ax2);
        title(['Contour: ' lbl '   (' pairs{k,3} ')']);
    end
    sgtitle(['Response surfaces - ' lbl]);
    saveas(gcf,fullfile(outdir,[fname '.png']));
end
