;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************


(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************
					
(defrule determine-begin-state ""

   (logical (start))

   =>

   (assert (UI-state (display StartQuestion)
                     (relation-asserted people-person)
                     (response No)
                     (valid-answers No Yes))))
 
(defrule determine-make-money ""

   (logical (people-person Yes))

   =>

   (assert (UI-state (display MoneyQuestion)
                     (relation-asserted make-money)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-fallen-in-love ""

   (logical (make-money Yes))

   =>

   (assert (UI-state (display inLoveQuestion)
                     (relation-asserted fallen-in-love)
                     (response No)
                     (valid-answers No Yes))))
          
(defrule determine-prudish ""

   (logical (fallen-in-love Yes))

   =>

   (assert (UI-state (display PrudishQuestion)
                     (relation-asserted prudish)
                     (response No)
                     (valid-answers No Yes))))

                     
                     
(defrule determine-bfa ""

   (logical (prudish No))

   =>

   (assert (UI-state (display bfaQuestion)
                     (relation-asserted bfa)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-Bleeding ""

   (logical (fallen-in-love No))

   =>

   (assert (UI-state (display BleedingQuestion)
                     (relation-asserted bleeding)
                     (response No)
                     (valid-answers No Yes))))
                     
(defrule determine-adrenaline ""

   (logical (bleeding Yes))

   =>

   (assert (UI-state (display AdrenalineQuestion)
                     (relation-asserted adrenaline)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-fetish ""

   (logical (adrenaline No))

   =>

   (assert (UI-state (display fetishQuestion)
                     (relation-asserted fetish)
                     (response No)
                     (valid-answers No Yes))))       
                     
(defrule determine-quick ""

   (logical (bleeding No))

   =>

   (assert (UI-state (display quickQuestion)
                     (relation-asserted quick)
                     (response No)
                     (valid-answers No Yes))))  
                     
(defrule determine-stone ""

   (logical (quick No))

   =>

   (assert (UI-state (display StoneQuestion)
                     (relation-asserted stone)
                     (response IFstone)
                     (valid-answers IFstone RollingStone StonePhillips Bloodstone))))                                                     
                      
(defrule determine-voyeur ""

   (logical (make-money No))

   =>

   (assert (UI-state (display voyeurQuestion)
                     (relation-asserted voyeur)
                     (response No)
                     (valid-answers No Yes)))) 

(defrule determine-agoraphobe ""

   (logical (voyeur Yes))

   =>

   (assert (UI-state (display AgoraphobeQuestion)
                     (relation-asserted agoraphobe )
                     (response No)
                     (valid-answers No Yes))))
(defrule determine-control_freak ""

   (logical (voyeur No))

   =>

   (assert (UI-state (display control_freakQuestion)
                     (relation-asserted control_freak )
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-destination ""

   (logical (control_freak No))

   =>

   (assert (UI-state (display destinationQuestion)
                     (relation-asserted destination )
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-own ""

   (logical (people-person No))

   =>

   (assert (UI-state (display ownQuestion)
                     (relation-asserted own)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-blog ""

   (logical (own Yes))

   =>

   (assert (UI-state (display blogQuestion )
                     (relation-asserted blog)
                     (response Top)
                     (valid-answers Top Lenscratch Conscientious))))

(defrule determine-Adams ""

   (logical (blog Top))

   =>

   (assert (UI-state (display AdamsQuestion )
                     (relation-asserted Adams)
                     (response Ansel)
                     (valid-answers Ansel Robert ))))
                     

(defrule determine-gear ""

   (logical (own No))

   =>

   (assert (UI-state (display GearQuestion)
                     (relation-asserted gear)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-mfa ""

   (logical (gear No))

   =>

   (assert (UI-state (display MFAQuestion)
                     (relation-asserted mfa)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-chilhood ""

   (logical (mfa Yes))

   =>

   (assert (UI-state (display ChilhoodQuestion )
                     (relation-asserted chilhood)
                     (response No)
                     (valid-answers No Yes))))
                     
(defrule determine-one_point ""

   (logical (chilhood No))

   =>

   (assert (UI-state (display one_pointQuestion  )
                     (relation-asserted one_point)
                     (response No)
                     (valid-answers No Yes))))   
                                       
(defrule determine-ocd ""

   (logical (one_point No))

   =>

   (assert (UI-state (display OCDQuestion  )
                     (relation-asserted ocd)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-operated_camera ""

   (logical (ocd No))

   =>

   (assert (UI-state (display  operated_cameraQuestion )
                     (relation-asserted operated_camera)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-belly ""

   (logical (operated_camera Yes))

   =>

   (assert (UI-state (display  BellybuttonQuestion )
                     (relation-asserted belly)
                     (response Innie)
                     (valid-answers Innie Outie))))

(defrule determine-nostalgia ""

   (logical (mfa No))

   =>

   (assert (UI-state (display nostalgiaQuestion )
                     (relation-asserted nostalgia)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-institutions ""

   (logical (nostalgia No))

   =>

   (assert (UI-state (display institutionsQuestion )
                     (relation-asserted institutions)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-oriented ""

   (logical (institutions No))

   =>

   (assert (UI-state (display  orientedQuestion)
                     (relation-asserted oriented)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-superfriend ""

   (logical (oriented Yes))

   =>

   (assert (UI-state (display  SuperfriendQuestion)
                     (relation-asserted superfriend)
                     (response Batman)
                     (valid-answers Batman Aquaman WonderWoman))))




                                                                                     
;;;****************
;;;* REPAIR RULES *
;;;****************

(defrule Answer-weddings ""

   (logical (prudish Yes))
   
   =>

   (assert (UI-state (display WeddingsAnswer)
                     (state final))))
                     
(defrule Answer-bfa-yes ""

   (logical (bfa Yes))
   
   =>

   (assert (UI-state (display EroticaAnswer)
                     (state final))))    
(defrule Answer-bfa-no ""

   (logical (bfa No))
   
   =>

   (assert (UI-state (display PornAnswer)
                     (state final)))) 
                     
(defrule Answer-adrenaline ""

   (logical (adrenaline Yes))
   
   =>

   (assert (UI-state (display WarAnswer)
                     (state final))))
                     
(defrule Answer-fetish-yes ""

   (logical (fetish Yes))
   
   =>

   (assert (UI-state (display BWAnswer)
                     (state final))))                     
                                             
(defrule Answer-fetish-no ""

   (logical (fetish No))
   
   =>

   (assert (UI-state (display SocialAnswer)
                     (state final))))                                                                                  
                     
(defrule Answer-quick ""

   (logical (quick Yes))
   
   =>

   (assert (UI-state (display SportsAnswer)
                     (state final))))                         
                     
                     
(defrule Answer-stone-if ""

   (logical (stone IFstone))
   
   =>

   (assert (UI-state (display JournalismAnswer)
                     (state final))))                               
                     
(defrule Answer-stone-rolling ""

   (logical (stone RollingStone))
   
   =>

   (assert (UI-state (display MusicAnswer)
                     (state final))))  
                     
(defrule Answer-stone-phillips""

   (logical (stone StonePhillips))
   
   =>

   (assert (UI-state (display StockAnswer)
                     (state final))))  
                     
(defrule Answer-stone-bloodstone ""

   (logical (stone Bloodstone))
   
   =>

   (assert (UI-state (display CommercialAnswer)
                     (state final))))   
                     
(defrule Answer-agoraphobe-yes ""

   (logical (agoraphobe Yes))
   
   =>

   (assert (UI-state (display GVSAnswer)
                     (state final)))) 

(defrule Answer-agoraphobe-no ""

   (logical (agoraphobe No))
   
   =>

   (assert (UI-state (display StreetAnswer)
                     (state final))))    
(defrule Answer-control_freak ""

   (logical (control_freak Yes))
   
   =>

   (assert (UI-state (display FineAnswer)
                     (state final))))  
                      
(defrule Answer-destination-yes ""

   (logical (destination Yes))
   
   =>

   (assert (UI-state (display TintypeAnswer)
                     (state final))))                     
                     
(defrule Answer-destination-no ""

   (logical (destination No))
   
   =>

   (assert (UI-state (display EnvrionmentalAnswer)
                     (state final))))                      
                     
(defrule Answer-Adams-Ansel ""

   (logical (Adams Ansel))
   
   =>

   (assert (UI-state (display fAnswer)
                     (state final))))   
                          
(defrule Answer-Adams-Robert ""

   (logical (Adams Robert))
   
   =>

   (assert (UI-state (display NeoAnswer)
                     (state final))))                                                  


(defrule Answer-blog-len ""

   (logical (blog Lenscratch))
   
   =>

   (assert (UI-state (display RuinAnswer)
                     (state final)))) 
(defrule Answer-blog-con ""

   (logical (blog Conscientious))
   
   =>

   (assert (UI-state (display StakeAnswer)
                     (state final)))) 

(defrule Answer-gear ""

   (logical (gear Yes))
   
   =>

   (assert (UI-state (display PrintsAnswer)
                     (state final))))

(defrule Answer-chilhood ""

   (logical (chilhood Yes))
   
   =>

   (assert (UI-state (display DomesticAnswer)
                     (state final))))


(defrule Answer-one_point ""

   (logical (one_point Yes))
   
   =>

   (assert (UI-state (display AbstractAnswer)
                     (state final))))
                    
(defrule Answer-ocd ""

   (logical (ocd Yes))
   
   =>

   (assert (UI-state (display TypologiesAnswer)
                     (state final)))) 

(defrule Answer-belly-innie ""

   (logical (belly Innie))
   
   =>

   (assert (UI-state (display AboutAnswer)
                     (state final))))

(defrule Answer-belly-outie ""

   (logical (belly Outie))
   
   =>

   (assert (UI-state (display LandscapesAnswer)
                     (state final))))

(defrule Answer-operated_camera ""

   (logical (operated_camera No))
   
   =>

   (assert (UI-state (display AppropriatedAnswer)
                     (state final))))

(defrule Answer-nostalgia ""

   (logical (nostalgia Yes))
   
   =>

   (assert (UI-state (display CardsAnswer)
                     (state final))))

(defrule Answer-institutions ""

   (logical (institutions Yes))
   
   =>

   (assert (UI-state (display ArchitecturalAnswer)
                     (state final))))

(defrule Answer-superfriend-bat ""

   (logical (superfriend Batman))
   
   =>

   (assert (UI-state (display NightAnswer)
                     (state final))))

(defrule Answer-superfriend-aqua ""

   (logical (superfriend Aquaman))
   
   =>

   (assert (UI-state (display UnderwaterAnswer)
                     (state final))))

(defrule Answer-superfriend-woman ""

   (logical (superfriend WonderWoman))
   
   =>

   (assert (UI-state (display AerialAnswer)
                     (state final))))

(defrule Answer-oriented ""

   (logical (oriented No))
   
   =>

   (assert (UI-state (display SurveillanceAnswer)
                     (state final))))


                                                                                                                                                                 
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
