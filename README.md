# transcoding suite
eclectic emacs lisp functions to transcode Indian scripts


## Easy does it -- search and replace
There are numerous tools online for transcoding Indian scripts, Peter Scharfs [web interface at The Sanskrit Library](https://www.sanskritlibrary.org/transcodeText.html) is probably the most multifunctional. But going online and copy-pasting text is cumbersome if you do a lot of transcoding, like for assembling teaching material that requires both original script and roman transliteration. Also one important feature for transcoding roman transliteration to Nāgarī seems to be missing in all transcoders I've tried (which isn't that many though): They preserve the whitespace between consonants of neighboring words and thus some editing in post is always necessary to make the output string conform to the conventions of the script. This collection of emacs-lisp functions allows the user to stay in the comfort of his or her own emacs setup and also tries to make the resulting unicode string to conform to the conventions of the resulting script as much as possible with simple means.

Of course, this collection is highly eclectic and tailored to suite my current workflow and the languages I'm working with (Sanskrit and Tibetan); more functions might follow at some point.

## Provided Functions
This suite currently provides the following interactive functions
- transcode_iast-nagari : Kṛṣṇa uvāca: oṃ tat sad iti nirdeśo brahmaṇas trividhaḥ smṛtaḥ / -> कृष्ण उवाच – ॐ तत्सदिति निर्देशो ब्रह्मणस्त्रिविधः स्मृतः ।
- transcode_nagari-iast : कृष्ण उवाच – ॐ तत्सदिति निर्देशो ब्रह्मणस्त्रिविधः स्मृतः । -> kṛṣṇa uvāca – oṃ tatsaditi nirdeśo brahmaṇastrividhaḥ smṛtaḥ |
- transcode_iast-slp1 : Kṛṣṇa uvāca: oṃ tat sad iti nirdeśo brahmaṇas trividhaḥ smṛtaḥ / ->  kfzRa uvAca: oM tat sad iti nirdeSo brahmaRas triviDaH smftaH /
- transcode_slp1-iast :  kfzRa uvAca: oM tat sad iti nirdeSo brahmaRas triviDaH smftaH / -> kṛṣṇa uvāca: oṃ tat sad iti nirdeśo brahmaṇas trividhaḥ smṛtaḥ /
- transcode_iast-hk : Kṛṣṇa uvāca: oṃ tat sad iti nirdeśo brahmaṇas trividhaḥ smṛtaḥ / -> kRSNa uvAca: oM tat sad iti nirdezo brahmaNas trividhaH smRtaH /
- transcode_hk-iast : kRSNa uvAca: oM tat sad iti nirdezo brahmaNas trividhaH smRtaH / -> kṛṣṇa uvāca: oṃ tat sad iti nirdeśo brahmaṇas trividhaḥ smṛtaḥ / 
- transcode_wylie-tibetan : | rig 'dzin Tshangs-dbyangs-rgya-mtsho | -> །རིག་འཛིན་ཚངས་དབྱངས་རྒྱ་མཚོ།

## Installation
1. Add *transcoding-suite.el* to a directory included in the list *load-path* or modify this list to include the directory with
   `(add-to-list 'load-path "/PATH/TO/transcoding-suite/")` in your init file,
2. add `(require 'transcoding-suite)` to your init-file.

## Usage
1. set region (default `M-SPC`) to include the strings you wish to transcode, otherwise the function defaults to the word left of point,
2. evaluate one of the above functions with `M-x transcode_INPUT-OUTPUT`,
3. (optional) if you are frequently using one or the other function, consider [creating a keybinding](https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Commands.html).
