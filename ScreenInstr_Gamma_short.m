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
%             'Imaginez le visage d''une personne effrayée.',
%             'Imaginez le visage d''un homme avec un chapeau.',
            'Imaginez le visage d''une personne qui vous a parlé aujourd''hui.',
%             'Faites tourner ce visage dans votre tête.',
            'Quelles traits lui sont très particuliers ?',
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
        
        ScreenInstr = {'Pensez à une fourchette.',
            'Faites tourner cette fourchette dans votre tête.',
            'Pensez aux noms d''autres ustensiles comme celui-ci.',
%             'Pensez à un objet émotionnellement important pour vous.',
%             'Faites tourner cet objet dans votre tête.',
%             'Pensez aux noms d''autres objets importants comme celui-ci.',
            'Pensez aux jouets préférés de votre enfance.',
            'Quels objets peut-on trouver dans votre salle de bains ?',
            'Pensez à une chaise et faites la tourner dans votre tête.',
            'Combien de T-shirts possédez-vous ?', % à retirer ?
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
        
        ScreenInstr = {'Imaginez vous promener dans une forêt.',
            'Imaginez une chaise et faites la tourner dans votre tête.',
            'Imaginez vous déplacer chez vous de pièce en pièce.',
            'Pensez à un endroit où vous vous sentez heureux.',
            'Imaginez y être et concentrez-vous sur vos sentiments.',
            'Imaginez vous promener dans votre quartier et nommez les rues.',
            'Imaginez être dans votre cuisine. Comptez les ustensiles.'
            'Imaginez un visage et faites le tourner dans votre tête.',
            
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
            'Repensez à un événement où vous étiez très triste.',
            'Pensez à un moment où vous avez ressenti de la compassion.',
            'Imaginez le visage d''une personne qui vous a parlé aujourd''hui.',
%             'Quelles traits lui sont très particuliers ?',
            'Pensez aux noms d''autres personnes en lien avec celle-ci.',
%             'Nommez des objets en rapport avec une voiture.',
            'Imaginez vous promener dans votre quartier et nommez les rues.',
%             'Pensez aux jouets préférés de votre enfance.',
%             'Quels objets peut-on trouver dans votre salle de bains ?',
            'Repensez à un moment où vous étiez détendu et reposez-vous.',
            'Combien de T-shirts possédez-vous ?', % à retirer ?
%             'Où et quand avez-vous fait du vélo pour les 3 dernières fois ?',
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
            'Pensez aux jouets préférés de votre enfance.',
            'Pensez à un endroit où vous vous sentez heureux(se).',
%             'Imaginez y être et concentrez-vous sur votre ressenti.',
            'Concentrez-vous sur vos sentiments actuels.',
            'Repensez à un événement où vous étiez très triste.',
            'Pensez à un moment où vous avez ressenti de la compassion.',
            'Imaginez le visage d''une personne qui vous est proche.',
            'Nommez d''autres personnes en rapport avec celle-ci.',
%             'Pensez à un objet émotionnellement important pour vous.',
%             'Pensez à un endroit qui vous a fortement impressionné(e).'
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
            'Repensez à un moment où vous étiez détendu et reposez-vous.',
            'Concentrez-vous sur votre respiration.',
            'Concentrez-vous sur votre corps et ses différentes parties.',
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
        
        ScreenInstr = {'Récitez l''alphabet à l''endroit puis à l''envers.',
            'Imaginez réciter la phrase "doubi-doubi-doubi...".',
            'Récitez les noms de vos proches en pensant à eux.',
            'Essayez de nommer tous les pays d''Europe.',
            'Nommez des objets en rapport avec une voiture.',
            'Imaginez vous promener dans votre quartier et nommez les rues.',
            'Imaginez réciter la phrase "chama-chama-chama...".',
            'Récitez vos tables de multiplication.'
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
        
        ScreenInstr = {'Combien de T-shirts possédez-vous ?', % à retirer ?
            'Imaginez être dans votre cuisine. Comptez les ustensiles.' % à retirer ?
            'Comptez à l''envers, par 3, à partir de 60',
            'Calculez 3x2, multipliez encore par deux, et encore, etc.',
            'Combien de visages avez-vous vus aujourd''hui ? Comptez-les.',
            'Récitez vos tables de multiplication.'
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
            'Pensez à un objet que vous aimez (voiture, bijou...).',
            'Nommez des objets en rapport avec celui-ci.',
            'Imaginez vous lever du lit et marcher dans la pièce.',
            'Qu''avez vous fait pour votre dernier anniversaire ?',
            'Concentrez-vous sur ce que vous ressentez.',
            'Concentrez-vous sur votre respiration.',
            'Comptez à l''envers, par 3, à partir de 60',
%             'Relaxez-vous et faites le vide.',
%             'Essayez de nommer tous les pays d''Europe.',
%             'Pensez à un événement où vous étiez très heureux(se).',
%             'Pensez au chemin à prendre pour rentrer du travail.'
            };
        
        
        
        
        
        
end