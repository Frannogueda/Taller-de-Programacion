{1) Una obra social dispone de un árbol binario de búsqueda con la información de sus 
afiliados. De cada afiliado se conoce: Número de afiliado, Nro de DNI, Plan (1..5) y año de
anio af la obra social. El árbol se encuentra ordenado por número de afiliado. Se 
solicita:
Implementar un módulo que reciba el árbol de afiliados, Nro de DNI Num1, Nro de DNI 
Num2 y un número de Plan, y retorne un vector ordenado por Nro de DNI del afiliado. El 
vector debe contener el número de afiliado y DNI de aquellos afiliados cuyo Nro de DNI se
encuentra comprendido entre Num1 y Num2 (siendo Num1 menor que Num2) y el Plan se
corresponda con el recibido por parámetro. Por norma de la obra social, cada Plan puede 
contar con af lo sumo 500 afiliados. }
program parcial;
	const 
		df=500;
	type
		Rango=1..5;
		afiliado:record
			NumA:integer;
			dni:integer;
			plan:Rango;
			anio:integer;
		afiliadoVec=record
			Dni:integer;
			NumA:integer;
		end;
		end;
		arbol=^nodo;
		nodo=record
			dato:afiliado;
			HD:arbol;
			HI:arbol;
		end;
		Vafiliados=array[1..df]of afiliadoVec;
	procedure cargarArbol(var a:arbol);
		begin
			//se dispone
		end;
	procedure VectorAfiliados(a:arbol; var v:Vafiliados; n1,n2:integer; Plan:Rango var dl:integer);
		function Cumple(a:afiliado; n1,n2:integer; Plan:Rango):boolean;
			begin
				if(a.plan=Plan)then
					if(a.dni>num1)and(a.dni<num2)then
						Cumple:=true
					else
						Cumple:=false
				else
					Cumple:=false
			end;
		procedure AgregarVector(var v:Vafiliados; a:afiliados);
			begin
				if(dl<df)then begin
					v[dl].Dni:=a.dni;
					v[dl].NumA:=a.NumA;
					dl:=dl+1;
				end;
			end;
		procedure OrdenarVector(var v:Vafiliados; dl:integer);
		var
			i,j,pos:integer; item:afiliados;
		begin
			for i:=1 to dl-1 do begin
				pos:=i;
				for j:=i+1 to dl do begin
					if(v[j].dni>v[pos].dni)then
						pos:=j;
				item:=v[pos];
				v[pos]:=v[i];
				v[i]:=item;
				end;
			end;
		end;
		begin
			if(a<>nil)and(dl<df)then begin
				VectorAfiliados(a^.HD,v,n1,n2,Plan);
				VectorAfiliados(a^.HD,v,n1,n2,Plan);
					if(Cumple(a^.dato,n1,n2,Plan)=true)then
						AgregarVector(v,a^.dato,dl);
				end
				else
					OrdenarVector(v,dl);
		end;
	var
		a:arbol; num1,num2,dl:integer; numPlan:Rango; v:Vafiliados;
	begin
		dl:=1;
		cargarArbol(a);//se dispone
		readln(num1); readln(num2); readln(numPlan);
		VectorAfiliados(a,v,num1,num2,numPlan,dl);
	end.
