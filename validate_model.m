% vary alpha_y:alpha_x
global period
global delta

duty_ratio = [1,0.8,0.5,0.2];
period = 180;
ratio_span = 0.1;

for i = 1:numel(ratio_span)
    ay_to_ax = ratio_span(i);
    
    for j = 1:numel(duty_ratio)
        tend = 15/duty_ratio(j);
        delta = duty_ratio(j)*period;
        tspan = 0:0.1:60*tend;

        %soln_1step = nfat_transloc_onestep(tspan);
        soln_2step = nfat_transloc_twostep(ay_to_ax,tspan);

        figure(3)
        %plot(soln_1step)
        hold on
        plot(soln_2step(:,2))
        pause
    end
end
