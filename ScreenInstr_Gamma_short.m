function [ScreenInstr] = ScreenInstr_Gamma_short(screening_type)

switch screening_type
    
    
    case 'Face'
        %    8 instructions:
        
        % Object = 1            (4)
        % V&Nav = 1             (2)
        % Memory = 6            (2, 3, 4, 5, 6, 7)
        % Emotion = 2           (1, 2)
        % Self-Awareness = 0    ()
        % Language = 2          (3, 7)
        % Number processing = 1 (8)
        
        ScreenInstr = {'Imaginez le visage d''une personne triste.',
            'Imaginez le visage d''un proche et faites le tourner.',
            'Pensez aux noms d''autres personnes en lien avec celle-ci.',
            'Imaginez le visage d''une femme aux boucles d''oreilles.',
%             'Imaginez le visage d''une personne effray�e.',
%             'Imaginez le visage d''un homme avec un chapeau.',
            'Imaginez le visage d''une personne qui vous a parl� aujourd''hui.',
%             'Faites tourner ce visage dans votre t�te.',
            'Quelles traits lui sont tr�s particuliers ?',
            'Pensez aux noms d''autres personnes en lien avec celle-ci.',
            'Combien de visages avez-vous vus aujourd''hui ? Comptez-les'  % ??
            };
        
        
    case 'Obj'
        %    8 instructions:
        %
        % Face = 1              (8)
        % V&Nav = 4             (2, 5, 6)
        % Memory = 6            (3, 4, 5, 7)
        % Emotion = 3           (4)
        % Self-Awareness = 0    ()
        % Language = 3          (3, 5)
        % Number processing = 0 (7)
        
        ScreenInstr = {'Pensez � une fourchette.',
            'Faites tourner cette fourchette dans votre t�te.',
            'Pensez aux noms d''autres ustensiles comme celui-ci.',
%             'Pensez � un objet �motionnellement important pour vous.',
%             'Faites tourner cet objet dans votre t�te.',
%             'Pensez aux noms d''autres objets importants comme celui-ci.',
            'Pensez aux jouets pr�f�r�s de votre enfance.',
            'Quels objets peut-on trouver dans votre salle de bains ?',
            'Pensez � une chaise et faites la tourner dans votre t�te.',
            'Combien de T-shirts poss�dez-vous ?', % � retirer ?
            'Imaginez le visage d''une femme aux boucles d''oreilles.',
            };
    case 'VNav'
        %    8 instructions:
        %
        % Face = 1              (8)
        % Object = 1            (2)
        % Memory = 5            (1, 3, 4, 6, 7)
        % Emotion = 2           (4, 5)
        % Self-Awareness = 1    (5)
        % Language = 1          (6)
        % Number processing = 1 (7)
        
        ScreenInstr = {'Imaginez vous promener dans une for�t.',
            'Imaginez une chaise et faites la tourner dans votre t�te.',
            'Imaginez vous d�placer chez vous de pi�ce en pi�ce.',
            'Pensez � un endroit o� vous vous sentez heureux.',
            'Imaginez y �tre et concentrez-vous sur vos sentiments.',
            'Imaginez vous promener dans votre quartier et nommez les rues.',
            'Imaginez �tre dans votre cuisine. Comptez les ustensiles.'
            'Imaginez un visage et faites le tourner dans votre t�te.',
            
            };
    case 'Memo'
        %    8 instructions:
        %
        % Face = 1              (4)
        % Object = 1            (8)
        % V&Nav = 1             (6)
        % Emotion = 2           (2, 3)
        % Self-Awareness = 1    (7)
        % Language = 2          (5, 6)
        % Number processing = 1 (8)
        
        ScreenInstr = {'Essayez de nommer tous les pays d''Europe.',
            'Repensez � un �v�nement o� vous �tiez tr�s triste.',
            'Pensez � un moment o� vous avez ressenti de la compassion.',
            'Imaginez le visage d''une personne qui vous a parl� aujourd''hui.',
%             'Quelles traits lui sont tr�s particuliers ?',
            'Pensez aux noms d''autres personnes en lien avec celle-ci.',
%             'Nommez des objets en rapport avec une voiture.',
            'Imaginez vous promener dans votre quartier et nommez les rues.',
%             'Pensez aux jouets pr�f�r�s de votre enfance.',
%             'Quels objets peut-on trouver dans votre salle de bains ?',
            'Repensez � un moment o� vous �tiez d�tendu et reposez-vous.',
            'Combien de T-shirts poss�dez-vous ?', % � retirer ?
%             'O� et quand avez-vous fait du v�lo pour les 3 derni�res fois ?',
            };
    case 'Emo'
        %    8 instructions:
        %
        % Face = 2              (1, 7)
        % Object = 2            (2)
        % V&Nav = 2             (3)
        % Memory = 7            (2, 3, 5, 6, 7, 8)
        % Self-Awareness = 3    (3?, 4)
        % Language = 1          (8)
        % Number processing = 0 ()
        
        ScreenInstr = {'Imaginez le visage d''une personne triste.',
            'Pensez aux jouets pr�f�r�s de votre enfance.',
            'Pensez � un endroit o� vous vous sentez heureux(se).',
%             'Imaginez y �tre et concentrez-vous sur votre ressenti.',
            'Concentrez-vous sur vos sentiments actuels.',
            'Repensez � un �v�nement o� vous �tiez tr�s triste.',
            'Pensez � un moment o� vous avez ressenti de la compassion.',
            'Imaginez le visage d''une personne qui vous est proche.',
            'Nommez d''autres personnes en rapport avec celle-ci.',
%             'Pensez � un objet �motionnellement important pour vous.',
%             'Pensez � un endroit qui vous a fortement impressionn�(e).'
            };
    case 'Self-A'
        %    5 instructions:
        %
        % Face = 0              ()
        % Object = 0            ()
        % V&Nav = 0             ()
        % Memory = 1            (2)
        % Emotion = 1           (1)
        % Language = 0          ()
        % Number processing = 0 ()
        
        ScreenInstr = {'Concentrez-vous sur vos sentiments.',
            'Repensez � un moment o� vous �tiez d�tendu et reposez-vous.',
            'Concentrez-vous sur votre respiration.',
            'Concentrez-vous sur votre corps et ses diff�rentes parties.',
            'Concentrez-vous sur ce que vous entendez autour de vous.'
            };
    case 'Lang'
        %    8 instructions:
        %
        % Face = 1              (3)
        % Object = 1            (5)
        % V&Nav = 1             (6)
        % Memory = 2            (3, 4)
        % Emotion = 0           ()
        % Self-Awareness = 0    ()
        % Number processing = 1 (8)
        
        ScreenInstr = {'R�citez l''alphabet � l''endroit puis � l''envers.',
            'Imaginez r�citer la phrase "doubi-doubi-doubi...".',
            'R�citez les noms de vos proches en pensant � eux.',
            'Essayez de nommer tous les pays d''Europe.',
            'Nommez des objets en rapport avec une voiture.',
            'Imaginez vous promener dans votre quartier et nommez les rues.',
            'Imaginez r�citer la phrase "chama-chama-chama...".',
            'R�citez vos tables de multiplication.'
            };
        
    case 'NumP'
        %    6 instructions:
        %
        % Face = 1              (6)
        % Object = 2            (1, 2)
        % V&Nav = 2             (2)
        % Memory = 4            (1, 2, 5, 6)
        % Emotion = 0           ()
        % Self-Awareness = 0    ()
        % Language = 1          (6)
        
        ScreenInstr = {'Combien de T-shirts poss�dez-vous ?', % � retirer ?
            'Imaginez �tre dans votre cuisine. Comptez les ustensiles.' % � retirer ?
            'Comptez � l''envers, par 3, � partir de 60',
            'Calculez 3x2, multipliez encore par deux, et encore, etc.',
            'Combien de visages avez-vous vus aujourd''hui ? Comptez-les.',
            'R�citez vos tables de multiplication.'
            };
        
    otherwise %'general'
        %    8 instructions:
        %                                                    Only
        % Face = 1              (1)                 | 1
        % Object = 2            (2, 3)              | 2
        % V&Nav = 1             (3)                 | 3
        % Memory = 1            (4)                 | 4
        % Emotion = 1           (3)                 | 
        % Self-Awareness = 2    (6, 7)              | 7
        % Language = 1          (3)                 | 
        % Number processing = 1 (8)                 | 8
        
        ScreenInstr = { 'Imaginez le visage d''une personne.',
            'Pensez � un objet que vous aimez (voiture, bijou...).',
            'Nommez des objets en rapport avec celui-ci.',
            'Imaginez vous lever du lit et marcher dans la pi�ce.',
            'Qu''avez vous fait pour votre dernier anniversaire ?',
            'Concentrez-vous sur ce que vous ressentez.',
            'Concentrez-vous sur votre respiration.',
            'Comptez � l''envers, par 3, � partir de 60',
%             'Relaxez-vous et faites le vide.',
%             'Essayez de nommer tous les pays d''Europe.',
%             'Pensez � un �v�nement o� vous �tiez tr�s heureux(se).',
%             'Pensez au chemin � prendre pour rentrer du travail.'
            };
        
        
        
        
        
        
end