program DecimalToBinary;

function ConvertToBinary(decimal: Integer): String;
begin
    if decimal > 0 then
        ConvertToBinary := ConvertToBinary(decimal div 2) + Chr(48 + (decimal mod 2))
    else
        ConvertToBinary := '';
end;

var
    num: Integer;
	binary:string;
begin
    repeat
        Write('Ingresa un numero decimal: ');
        Readln(num);
        if num <> 0 then
        begin
            binary := ConvertToBinary(num);
            writeln('El equivalente en binario es: ', binary);
        end;
    until num = 0;
end.
{se genero con chatgpt}
