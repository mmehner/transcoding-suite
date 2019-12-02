(provide 'transcoding-suite)

;; narrowing to relevant region, called at the beginning of each function
(defun transcode-narrow ()
  (when (not mark-active)
    (left-word)
    (mark-word))
  (narrow-to-region (region-beginning) (region-end)))

;; asymmetric transcoding
(defun transcode_iast-nagari ()
  (interactive)
  (transcode-narrow)
  ;; some prelinary replacements, including stringing together consonants that are only separated by whitespace
  (mapc (lambda (list)
	  (goto-char (point-min))
	  (while (re-search-forward (eval (car list)) nil t)
	    (replace-match (eval (cdr list)) t nil)))
	'(("[/|]" . ".")
	  (" *\\(\\.+\\)\\( +\\|$\\)" . " \\1 ")
	  (" *: *" . " – ")
	  (" *(\\([0-9\.,IVXLMC]+\\))" . " .. \\1 ..")
	  ("\\([kgṅcjñṭḍṇtdnpbmyrlvśṣsh]\\) +\\([kgṅcjñṭḍṇtdnpbmyrlvśṣshaāiīuūṛṝḷeo]\\)" . "\\1\\2")
	  ("\\([0-9]\\)\.\\([0-9]\\)" . "\\1,\\2"))
	)
  ;; normalizing whitespace and inserting virāmas between consonants
  (delete-trailing-whitespace)
  (goto-char (point-min))
  (while (>= (count-matches "\\([kgṅcjñṭḍṇtdnpbmyrlvśṣsh]\\)\\([kgṅcjñṭḍṇtdnpbmyrlvśṣs]\\)") 1)
    (while (re-search-forward "\\([kgṅcjñṭḍṇtdnpbmyrlvśṣsh]\\)\\([kgṅcjñṭḍṇtdnpbmyrlvśṣs]\\)" nil t)
      (replace-match "\\1्\\2" t nil))
    (goto-char (point-min))
    )
  ;; final replacements
  (mapc (lambda (list)
	  (goto-char (point-min))
	  (while (re-search-forward (eval (car list)) nil t)
	    (replace-match (eval (cdr list)) t nil)))
	'(("\\([kgṅcjñṭḍṇtdnpbmyrlvśṣsh]\\)[ \n]" . "\\1् ")
	  ("\\([ \n]\\)o[ṃm] " . "\\1ॐ ")
	  ("\\." . "।")
	  ("kh" . "ख")
	  ("gh" . "घ")
	  ("ch" . "छ")
	  ("jh" . "झ")
	  ("ṭh" . "ठ")
	  ("ḍh" . "ढ")
	  ("th" . "थ")
	  ("dh" . "ध")
	  ("ph" . "फ")
	  ("bh" . "भ")
	  ("k" . "क")
	  ("g" . "ग")
	  ("ṅ" . "ङ")
	  ("c" . "च")
	  ("j" . "ज")
	  ("ñ" . "ञ")
	  ("ṭ" . "ट")
	  ("ḍ" . "ड")
	  ("ṇ" . "ण")
	  ("t" . "त")
	  ("d" . "द")
	  ("n" . "न")
	  ("p" . "प")
	  ("b" . "ब")
	  ("m" . "म")
	  ("y" . "य")
	  ("r" . "र")
	  ("l" . "ल")
	  ("v" . "व")
	  ("ś" . "श")
	  ("ṣ" . "ष")
	  ("s" . "स")
	  ("h" . "ह")
	  ("\\([ \n]\\)ai" . "\\1ऐ")
	  ("\\([ \n]\\)au" . "\\1औ")
	  ("\\([ \n]\\)a" . "\\1अ")
	  ("\\([ \n]\\)ā" . "\\1आ")
	  ("\\([ \n]\\)i" . "\\1इ")
	  ("\\([ \n]\\)ī" . "\\1ई")
	  ("\\([ \n]\\)u" . "\\1उ")
	  ("\\([ \n]\\)ū" . "\\1ऊ")
	  ("\\([ \n]\\)ṛ" . "\\1ऋ")
	  ("\\([ \n]\\)ṝ" . "\\1ॠ")
	  ("\\([ \n]\\)ḷ" . "\\1लृ")
	  ("\\([ \n]\\)ḹ" . "\\1लॄ")
	  ("\\([ \n]\\)e" . "\\1ए")
	  ("\\([ \n]\\)o" . "\\1ओ")
	  ("'" . "ऽ")
	  ("ai" . "ै")
	  ("au" . "ौ")
	  ("a" . "")
	  ("ā" . "ा")
	  ("i" . "ि")
	  ("ī" . "ी")
	  ("u" . "ु")
	  ("ū" . "ू")
	  ("ṛ" . "ृ")
	  ("ṝ" . "ॄ")
	  ("ḷ" . "ॢ")
	  ("ḹ" . "ॣ")
	  ("e" . "े")
	  ("o" . "ो")
	  ("ṃ" . "ं")
	  ("ḥ" . "ः")
	  ("ḫ" . "ः")
	  ("ẖ" . "ः")
	  ("1" . "१")
	  ("2" . "२")
	  ("3" . "३")
	  ("4" . "४")
	  ("5" . "५")
	  ("6" . "६")
	  ("7" . "७")
	  ("8" . "८")
	  ("9" . "९")
	  ("0" . "०"))
	)
  (widen)
  )

(defun transcode_nagari-iast ()
  (interactive)
  (transcode-narrow)
  (mapc (lambda (list)
	  (goto-char (point-min))
	  (while (re-search-forward (eval (cdr list)) nil t)
	    (replace-match (eval (car list)) t nil))
	  )
	'((": " . " *– *")
	  ("oṃ" . "ॐ")
	  ("्ai" . "ै")
	  ("्au" . "ौ")
	  ("्ā" . "ा")
	  ("्i" . "ि")
	  ("्ī" . "ी")
	  ("्u" . "ु")
	  ("्ū" . "ू")
	  ("्ṛ" . "ृ")
	  ("्ṝ" . "ॄ")
	  ("्ḷ" . "ॢ")
	  ("्ḹ" . "ॣ")
	  ("्e" . "े")
	  ("्o" . "ो")
	  ("|" . "।")
	  ("kh" . "ख्")
	  ("gh" . "घ्")
	  ("ch" . "छ्")
	  ("jh" . "झ्")
	  ("ṭh" . "ठ्")
	  ("ḍh" . "ढ्")
	  ("th" . "थ्")
	  ("dh" . "ध्")
	  ("ph" . "फ्")
	  ("bh" . "भ्")
	  ("k" . "क्")
	  ("g" . "ग्")
	  ("ṅ" . "ङ्")
	  ("c" . "च्")
	  ("j" . "ज्")
	  ("ñ" . "ञ्")
	  ("ṭ" . "ट्")
	  ("ḍ" . "ड्")
	  ("ṇ" . "ण्")
	  ("t" . "त्")
	  ("d" . "द्")
	  ("n" . "न्")
	  ("p" . "प्")
	  ("b" . "ब्")
	  ("m" . "म्")
	  ("y" . "य्")
	  ("r" . "र्")
	  ("l" . "ल्")
	  ("v" . "व्")
	  ("ś" . "श्")
	  ("ṣ" . "ष्")
	  ("s" . "स्")
	  ("h" . "ह्")
	  ("kha" . "ख")
	  ("gha" . "घ")
	  ("cha" . "छ")
	  ("jha" . "झ")
	  ("ṭha" . "ठ")
	  ("ḍha" . "ढ")
	  ("tha" . "थ")
	  ("dha" . "ध")
	  ("pha" . "फ")
	  ("bha" . "भ")
	  ("ka" . "क")
	  ("ga" . "ग")
	  ("ṅa" . "ङ")
	  ("ca" . "च")
	  ("ja" . "ज")
	  ("ña" . "ञ")
	  ("ṭa" . "ट")
	  ("ḍa" . "ड")
	  ("ṇa" . "ण")
	  ("ta" . "त")
	  ("da" . "द")
	  ("na" . "न")
	  ("pa" . "प")
	  ("ba" . "ब")
	  ("ma" . "म")
	  ("ya" . "य")
	  ("ra" . "र")
	  ("la" . "ल")
	  ("va" . "व")
	  ("śa" . "श")
	  ("ṣa" . "ष")
	  ("sa" . "स")
	  ("ha" . "ह")
	  ("ai" . "ऐ")
	  ("au" . "औ")
	  ("a" . "अ")
	  ("ā" . "आ")
	  ("i" . "इ")
	  ("ī" . "ई")
	  ("u" . "उ")
	  ("ū" . "ऊ")
	  ("ṛ" . "ऋ")
	  ("ṝ" . "ॠ")
	  ("ḷ" . "लृ")
	  ("ḹ" . "लॄ")
	  ("e" . "ए")
	  ("o" . "ओ")
	  ("'" . "ऽ")
	  ("ṃ" . "ं")
	  ("ḥ" . "ः")
	  ("1" . "१")
	  ("2" . "२")
	  ("3" . "३")
	  ("4" . "४")
	  ("5" . "५")
	  ("6" . "६")
	  ("7" . "७")
	  ("8" . "८")
	  ("9" . "९")
	  ("0" . "०"))
	)
  (widen)
  )

(defun transcode_wylie-tibetan ()
  (interactive)
  (transcode-narrow)
  (mapc (lambda (list)
	  (goto-char (point-min))
	  (while (re-search-forward (eval (car list)) nil t)
	    (replace-match (eval (cdr list)) t nil))
	  )
	'(("-" . " ")
	  ("rk\\([aiueo]\\)" .  "རྐ\\1")
	  ("rky\\([aiueo]\\)" .  "རྐྱ\\1")
	  ("rg\\([aiueo]\\)" .  "རྒ\\1")
	  ("rgy\\([aiueo]\\)" .  "རྒྱ\\1")
	  ("rgw\\([aiueo]\\)" .  "རྒྭ\\1")
	  ("rng\\([aiueo]\\)" .  "རྔ\\1")
	  ("rj\\([aiueo]\\)" .  "རྗ\\1")
	  ("rny\\([aiueo]\\)" .  "རྙ\\1")
	  ("rt\\([aiueo]\\)" .  "རྟ\\1")
	  ("rd\\([aiueo]\\)" .  "རྡ\\1")
	  ("rn\\([aiueo]\\)" .  "རྣ\\1")
	  ("rb\\([aiueo]\\)" .  "རྦ\\1")
	  ("rm\\([aiueo]\\)" .  "རྨ\\1")
	  ("rts\\([aiueo]\\)" .  "རྩ\\1")
	  ("rdz\\([aiueo]\\)" .  "རྫ\\1")
	  ("lk\\([aiueo]\\)" .  "ལྐ\\1")
	  ("lg\\([aiueo]\\)" .  "ལྒ\\1")
	  ("lng\\([aiueo]\\)" .  "ལྔ\\1")
	  ("lc\\([aiueo]\\)" .  "ལྕ\\1")
	  ("lj\\([aiueo]\\)" .  "ལྗ\\1")
	  ("lt\\([aiueo]\\)" .  "ལྟ\\1")
	  ("ld\\([aiueo]\\)" .  "ལྡ\\1")
	  ("lp\\([aiueo]\\)" .  "ལྤ\\1")
	  ("lb\\([aiueo]\\)" .  "ལྦ\\1")
	  ("lh\\([aiueo]\\)" .  "ལྷ\\1")
	  ("sk\\([aiueo]\\)" .  "སྐ\\1")
	  ("skr\\([aiueo]\\)" .  "སྐྲ\\1")
	  ("sky\\([aiueo]\\)" .  "སྐྱ\\1")
	  ("sg\\([aiueo]\\)" .  "སྒ\\1")
	  ("sgy\\([aiueo]\\)" .  "སྒྱ\\1")
	  ("sgr\\([aiueo]\\)" .  "སྒྲ\\1")
	  ("sng\\([aiueo]\\)" .  "སྔ\\1")
	  ("sny\\([aiueo]\\)" .  "སྙ\\1")
	  ("st\\([aiueo]\\)" .  "སྟ\\1")
	  ("sd\\([aiueo]\\)" .  "སྡ\\1")
	  ("sn\\([aiueo]\\)" .  "སྣ\\1")
	  ("snr\\([aiueo]\\)" .  "སྣྲ\\1")
	  ("sp\\([aiueo]\\)" .  "སྤ\\1")
	  ("spr\\([aiueo]\\)" .  "སྤྲ\\1")
	  ("spy\\([aiueo]\\)" .  "སྤྱ\\1")
	  ("sb\\([aiueo]\\)" .  "སྦ\\1")
	  ("sby\\([aiueo]\\)" .  "སྦྱ\\1")
	  ("sbr\\([aiueo]\\)" .  "སྦྲ\\1")
	  ("sm\\([aiueo]\\)" .  "སྨ\\1")
	  ("smr\\([aiueo]\\)" .  "སྨྲ\\1")
	  ("smy\\([aiueo]\\)" .  "སྨྱ\\1")
	  ("sts\\([aiueo]\\)" .  "སྩ\\1")
	  ("ky\\([aiueo]\\)" .  "ཀྱ\\1")
	  ("khy\\([aiueo]\\)" .  "ཁྱ\\1")
	  ("gy\\([aiueo]\\)" .  "གྱ\\1")
	  ("py\\([aiueo]\\)" .  "པྱ\\1")
	  ("phy\\([aiueo]\\)" .  "ཕྱ\\1")
	  ("phyw\\([aiueo]\\)" .  "ཕྱྭ\\1")
	  ("by\\([aiueo]\\)" .  "བྱ\\1")
	  ("my\\([aiueo]\\)" .  "མྱ\\1")
	  ("kr\\([aiueo]\\)" .  "ཀྲ\\1")
	  ("khr\\([aiueo]\\)" .  "ཁྲ\\1")
	  ("gr\\([aiueo]\\)" .  "གྲ\\1")
	  ("grw\\([aiueo]\\)" .  "གྲྭ\\1")
	  ("tr\\([aiueo]\\)" .  "ཏྲ\\1")
	  ("thr\\([aiueo]\\)" .  "ཐྲ\\1")
	  ("dr\\([aiueo]\\)" .  "དྲ\\1")
	  ("pr\\([aiueo]\\)" .  "པྲ\\1")
	  ("phr\\([aiueo]\\)" .  "ཕྲ\\1")
	  ("br\\([aiueo]\\)" .  "བྲ\\1")
	  ("mr\\([aiueo]\\)" .  "མྲ\\1")
	  ("shr\\([aiueo]\\)" .  "ཤྲ\\1")
	  ("sr\\([aiueo]\\)" .  "སྲ\\1")
	  ("hr\\([aiueo]\\)" .  "ཧྲ\\1")
	  ("kl\\([aiueo]\\)" .  "ཀླ\\1")
	  ("gl\\([aiueo]\\)" .  "གླ\\1")
	  ("bl\\([aiueo]\\)" .  "བླ\\1")
	  ("zl\\([aiueo]\\)" .  "ཟླ\\1")
	  ("rl\\([aiueo]\\)" .  "རླ\\1")
	  ("sl\\([aiueo]\\)" .  "སླ\\1")
	  ("kw\\([aiueo]\\)" .  "ཀྭ\\1")
	  ("khw\\([aiueo]\\)" .  "ཁྭ\\1")
	  ("gw\\([aiueo]\\)" .  "གྭ\\1")
	  ("cw\\([aiueo]\\)" .  "ཅྭ\\1")
	  ("nyw\\([aiueo]\\)" .  "ཉྭ\\1")
	  ("tw\\([aiueo]\\)" .  "ཏྭ\\1")
	  ("dw\\([aiueo]\\)" .  "དྭ\\1")
	  ("tsw\\([aiueo]\\)" .  "ཙྭ\\1")
	  ("tshw\\([aiueo]\\)" .  "ཚྭ\\1")
	  ("zhw\\([aiueo]\\)" .  "ཞྭ\\1")
	  ("zw\\([aiueo]\\)" .  "ཟྭ\\1")
	  ("rw\\([aiueo]\\)" .  "རྭ\\1")
	  ("lw\\([aiueo]\\)" .  "ལྭ\\1")
	  ("shw\\([aiueo]\\)" .  "ཤྭ\\1")
	  ("sw\\([aiueo]\\)" .  "སྭ\\1")
	  ("hw\\([aiueo]\\)" .  "ཧྭ\\1")
	  ("g\\.y\\([aiueo]\\)" .  "གཡ\\1")
	  ("kh" . "ཁ")
	  ("ng" . "ང")
	  ("ch" . "ཆ")
	  ("ny" . "ཉ")
	  ("th" . "ཐ")
	  ("ph" . "ཕ")
	  ("tsh" . "ཚ")
	  ("ts" . "ཙ")
	  ("dz" . "ཛ")
	  ("zh" . "ཞ")
	  ("sh" . "ཤ")
	  ("k" . "ཀ")
	  ("g" . "ག")
	  ("c" . "ཅ")
	  ("j" . "ཇ")
	  ("t" . "ཏ")
	  ("d" . "ད")
	  ("n" . "ན")
	  ("p" . "པ")
	  ("b" . "བ")
	  ("m" . "མ")
	  ("w" . "ཝ")
	  ("z" . "ཟ")
	  ("'" . "འ")
	  ("y" . "ཡ")
	  ("r" . "ར")
	  ("l" . "ལ")
	  ("s" . "ས")
	  ("h" . "ཧ")
	  (" a " . "་ཨ་")
	  (" i " . "་ཨི་")
	  (" u " . "་ཨུ་")
	  (" e " . "་ཨེ་")
	  (" o " . "་ཨོ་")
	  ("a" . "")
	  ("i" . "ི")
	  ("u" . "ུ")
	  ("e" . "ེ")
	  ("o" . "ོ")
	  (" *[\\.|] *" . "།")
	  (" " . "་")
	  ("1" . "༡")
	  ("2" . "༢")
	  ("3" . "༣")
	  ("4" . "༤")
	  ("5" . "༥")
	  ("6" . "༦")
	  ("7" . "༧")
	  ("8" . "༨")
	  ("9" . "༩")
	  ("0" . "༠")))
  (widen)
  )

;; symmetric transcoding (between various romanizations)

(defun transcode-list_iast-slp1 ()
  (setq repl-list '(("ā" . "A")
		    ("ī" . "I")
		    ("ū" . "U")
		    ("ai" . "E")
		    ("au" . "O")
		    ("ṛ" . "f")
		    ("ṝ" . "F")
		    ("ḷ" . "x")
		    ("ḹ" . "X")
		    ("ṃ" . "M")
		    ("ḥ" . "H")
		    ("ḫ" . "H")
		    ("ẖ" . "H")
		    ("kh" . "K")
		    ("gh" . "G")
		    ("ṅ" . "N")
		    ("ch" . "C")
		    ("jh" . "J")
		    ("ñ" . "Y")
		    ("ṭ" . "w")
		    ("ṭh" . "W")
		    ("ḍ" . "q")
		    ("ḍh" . "Q")
		    ("ṇ" . "R")
		    ("th" . "T")
		    ("dh" . "D")
		    ("ph" . "P")
		    ("bh" . "B")
		    ("ś" . "S")
		    ("ṣ" . "z"))))

(defun transcode-list_iast-hk ()
  (setq repl-list '(("ā" . "A")
		    ("ī" . "I")
		    ("ū" . "U")
		    ("ṛ" . "R")
		    ("ṝ" . "RR")
		    ("ḷ" . "L")
		    ("ḹ" . "LL")
		    ("ṃ" . "M")
		    ("ḥ" . "H")
		    ("ḫ" . "H")
		    ("ẖ" . "H")
		    ("ṅ" . "G")
		    ("ñ" . "J")
		    ("ṭ" . "T")
		    ("ḍ" . "D")
		    ("ṇ" . "N")
		    ("ś" . "z")
		    ("ṣ" . "S"))))

(defun transcode_iast-slp1 ()
  (interactive)
  (transcode-narrow)
  (downcase-region (point-min) (point-max))
  (transcode-list_iast-slp1)
  (mapc (lambda (list)
	  (goto-char (point-min))
	  (while (re-search-forward (eval (car list)) nil t)
	    (replace-match (eval (cdr list)) t nil))
	  )
	repl-list
	)
  (widen)
  )

(defun transcode_slp1-iast ()
  (interactive)
  (transcode-narrow)
  (transcode-list_iast-slp1)
  (let ((case-fold-search nil)) 
    (mapc (lambda (list)
	    (goto-char (point-min))
	    (while (re-search-forward (eval (cdr list)) nil t)
	      (replace-match (eval (car list)) t nil))
	    )
	  repl-list
	  )
    )
  (widen)
  )

(defun transcode_iast-hk ()
  (interactive)
  (transcode-narrow)
  (downcase-region (point-min) (point-max))
  (transcode-list_iast-hk)
  (mapc (lambda (list)
	  (goto-char (point-min))
	  (while (re-search-forward (eval (car list)) nil t)
	    (replace-match (eval (cdr list)) t nil))
	  )
	repl-list
	)
  (widen)
  )

(defun transcode_hk-iast ()
  (interactive)
  (transcode-narrow)
  (transcode-list_iast-hk)
  (let ((case-fold-search nil)) 
    (mapc (lambda (list)
	    (goto-char (point-min))
	    (while (re-search-forward (eval (cdr list)) nil t)
	      (replace-match (eval (car list)) t nil))
	    )
	  repl-list
	  )
    )
  (widen)
  )