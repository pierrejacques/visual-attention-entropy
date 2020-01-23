function map = heat(fixations, r)

    width = 1280;
    height = 800;

    map = zeros(width, height);
    
    kernel = getKernel(r);
    
    for fixation = fixations'
        
        duration = fixation(2);
        x = fixation(3);
        y = fixation(4);
        
        if x > 0 && x <= width && y > 0 && y <= height
            map = kernelize(map, duration * kernel, x, y);
        end
        
    end
    
end

function output = kernelize(input, kernel, x, y)

    d = size(kernel, 1);
    
    r = (d - 1) / 2;
    
    [xmax, ymax] = size(input);
    
    xup = max(1, x-r);
    kxup = max(r-x+2, 1);
    
    xdown = min(xmax, x+r);
    kxdown = min(d + xmax - x - r, d);
    
    yleft = max(1, y-r);
    kyleft = max(r-y+2, 1);
    
    yright = min(ymax, y+r);
    kyright = min(d + ymax - y - r, d);
    
    output = [
        input(1:xup - 1, :);
        input(xup:xdown, 1:yleft-1), input(xup:xdown, yleft:yright)+ kernel(kxup:kxdown, kyleft:kyright), input(xup:xdown, yright + 1:ymax);
        input(xdown + 1:xmax,:)
    ];
end

function kernel = getKernel(r)
    kernel = fspecial('gaussian', 6*r + 1, r);
    threshold = kernel(3*r+1, 1);
    kernel(kernel < threshold) = 0;
    
end