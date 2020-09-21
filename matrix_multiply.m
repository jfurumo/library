%this function multiplies two matrices the old-fashioned way

function product = matrix_multiply(mat1,mat2)

%mat1=randi(9,[3,4]);
%mat2=randi(9,[4,3]);

[n1,m1]=size(mat1);
[n2,m2]=size(mat2);

if m1 == n2 %matrix dimensions must match in order to multiply
    product=zeros(n1,m2); %initialize product
    sum=0; %initialize sum
    for i=1:n1
        for j=1:m2
            %product(i,j)=mat1(i,:)*mat2(:,j); %row-by-column
            %multiplication
            for k=1:m1
                product(i,j)=product(i,j)+mat1(i,k)*mat2(k,j); %discrete matrix element multiplication and summation
            end
        end
    end   
    
%check
product;
%product_easy=mat1*mat2

else
    disp('matrix multiplication not possible')
end    
