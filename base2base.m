function base2base(liczba, podstawa1, podstawa2, ilepoprzecinku)
%KONWERSJALICZB - konwerter sytemo w liczbowych ka zdy na kaz dy z przedzia lu
%2:64.
%   KONWERSJALICZB(liczba,podstawa, podstawa2, ilepoprzecinku) konwertuje
%   dowolna  liczbe  z systemu liczbowego 2:64 na dowolny system liczbowy
%   z przedzial u 2:64.
%
%   Przyjmowane parametry:
%   liczba - dowolna liczba zapisana w systemie liczbowym 2:64.
%   podstawa2 - liczba okre slaj aca w jakim systemie liczbowym jest liczba.
%   podstawa2 - liczba okre slaj aca na jaki system liczbowy zamieni c liczbe .
%   ilepoprzecinku - okre sla ile wy swietli  liczb po przecinku. Nie podanie
%   tego paramtru spowoduje wy swietlenie domy slne 8 miejsc po przecinku.
%
%   Przyk ad
%      konwersjaLiczb(212,3,10) zwraca wynik 23
%      konwersjaLiczb(212,3,10,0) zwraca wynik 23
%

%   Copyright 2016
%   $Revision: 1.0.0.0 $  $Date: 2016/05/05 22:43:13 $

%   Kamil Feliszewski, 05 May 2016

narginchk(3,4) %sprawdzamy czy liczba podanych parametr ow wynosi min 3 i max 4
if nargin < 4 %jez eli liczba parametro w jest mniejsza ni  4, ostatni 4 parametr ma ustawiana  domys lna  wartosc  
    ilepoprzecinku=8;
end
    znak=['0':'9' 'A':'Z' 'a':'z' '[]'];
   %liczba
    cc=fix(liczba);
    cu=liczba-cc;
    reszta=0;
    zmienna1=0;

    str_cc='';
    str_cu='';

    str_liczba=num2str(liczba);
    str_liczba2=num2str(cc);
    str_liczbaCU=(cu);
    %str_liczbaCU
    przecinek=strfind(str_liczba, '.');
    %C = str_liczba(przecinek+1:end);

    if podstawa1 == podstawa2 %jez eli aktualny system liczbowy r owna si e nowy system liczbowy to wy swietlamy liczbe  bez obliczen 
        liczba
    else
        if podstawa1~=10
            if (podstawa1 < 1 || podstawa1 > 64 || floor(podstawa1) ~= podstawa1)
                error(message('zly zakres 1:64'));
            end

            h = char(str_liczba2);

            if ~isempty(find(h==' ' | h==0,1)),
                h = strjust(h);
                h(h==' ' | h==0) = '0';
            end

            [m,n] = size(h);
            bArr = [ones(m,1) cumprod(podstawa1(ones(m,n-1)),2)];
            values = -1*ones(256,1);
            values(double('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz[]')) = 0:63;
            if any(any(values(h) >= podstawa1 | values(h) < 0))
                error(message('MATLAB:base2dec:NumberOutsideRange', h, podstawa1));
            end
            a = fliplr(reshape(values(abs(h)),size(h)));
            cc=sum((bArr .* a),2);
            if podstawa2==10 %wys wietlamy wynik tylko gdy podstawa2=10 i nie ma przecinka
                if przecinek==0
                    cc
                end
            end

            if przecinek~=0

                x=1;
                temp=podstawa1;
                podstawa1=podstawa1^-1;
                str_liczbaCU=num2str(cu);
               % cu
            %str_liczbaCU
                for i=3 : length(str_liczbaCU)
                    zmienna1=str2num(str_liczbaCU(i))*podstawa1;
                    reszta=reszta+zmienna1;
                    x=x+1;
                    podstawa1=temp^-x;
                end
            end
        end
        %reszta
        %cc
        %zmienna1
        %reszta
        %str_cu=num2str(reszta);
        if podstawa2==10
            reszta=num2str(reszta);
            wynik=[num2str(cc),'.',reszta(3:end)]
        end

        if podstawa2~=10

            %10 na kazdy
            while 1
                r=mod(cc, podstawa2);
                cc=fix(cc/podstawa2);
                str_cc=[znak(r+1) str_cc];
                if cc==0
                    break;
                end
            end
            %str_cc
            str_cu='';

            if przecinek~=0
                %cu=str2num(C);
                %reszta
                if podstawa1~=10
                    cu=reszta;
                end
                if podstawa1==10
                    cu = str_liczbaCU;
                end
                %cu
                r=0;
                %podstawa2=podstawa^-1;
                z=1;
                while z<=ilepoprzecinku
                    %r=mod(cu, podstawa2);
                    if cu>=1
                        cu=cu-r;
                    end
                    cu=(cu*podstawa2);
                    r=fix(cu);
                    str_cu=[str_cu znak(r+1)];
                    z=z+1;
                    if cu==0
                        break;
                    end
                end
                %str_cu

            end
            if przecinek ~=0
                wynikz10=[str_cc,'.',str_cu]
            else
                wynikz10=[str_cc]
            end
        end

    end

end



