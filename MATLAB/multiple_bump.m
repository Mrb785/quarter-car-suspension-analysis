function zr = multiple_bump(t)

% Multiple-bump road excitation

zr = 0;

if t >= 0.5 && t <= 0.75
    a = 0.10;
    zr = a/2 * (1 - cos(8*pi*t));
elseif t >= 3.0 && t <= 3.25
    a = 0.05;
    zr = a/2 * (1 - cos(8*pi*t));
elseif t >= 5.0 && t <= 5.25
    a = 0.10;
    zr = a/2 * (1 - cos(8*pi*t));
else
    zr = 0;
end

end
