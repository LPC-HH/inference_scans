# inference scans

- Make a fresh area on lxplus, for example:
```bash
mkdir ~/work/HH
```
- Setup inference by following instructions here: https://gitlab.cern.ch/hh/tools/inference#1-source-the-setup
  - Set up the environment in a new folder with a clean environment (no `cmsenv`, ETC.)
  - Use `some_name` as the name of the environment.
```bash
git clone ssh://git@gitlab.cern.ch:7999/hh/tools/inference.git
cd inference
source setup.sh some_name
```
- Add the following to your `.setups/some_name.sh` file:
```bash
# common settings and hook file for combination (important)                                                                                    
export DHI_DATACARDS_RUN2="/eos/user/w/woodson/HH_fullRun2_fits/datacards_run2"
export DHI_STORE="/eos/user/w/woodson/HH_fullRun2_fits"
export DHI_HOOK_FILE="$DHI_BASE/dhi/hooks/run2_combination.py"
export PLOTS_COLLECTION="/eos/user/w/woodson/HH_fullRun2_fits/plots_postapproval"
export IMPACT_LABELS="/eos/user/w/woodson/HH_fullRun2_fits/misc/nuisance_labels.py"
export DHI_LIMIT_GRID_PATH="/eos/user/w/woodson/HH_fullRun2_fits/misc"

export C4bggf="bbbb_boosted_ggf/v6"
export C4bggf1="bbbb_boosted_ggf/v6/SRBin1"
export C4bggf2="bbbb_boosted_ggf/v6/SRBin2"
export C4bggf3="bbbb_boosted_ggf/v6/SRBin3"
export C4bvbf="bbbb_boosted_vbf/v4"
export C4bcomb="bbbb_boosted_vbf/v4,bbbb_boosted_ggf/v6"

export MULTICARDS="$C4bcomb:$C4bggf1:$C4bggf2:$C4bggf3:$C4bvbf"
export MULTINAMES="Combined,ggF cat. 1,ggF cat. 2,ggF cat. 3,VBF cat."
export MODEL_BOOSTED="hh_model_boosted.model_boosted"
export VERSION="postapproval"
```
- Checkout this repo inside of `inference`
```bash
git clone git@github.com:LPC-HH/inference_scans.git
```
- Finally, from the `inference_scans` directory in `screen` or `tmux`, run the script you want, e.g.:
```bash
source setup.sh some_name # required before running a scan
cd inference_scans
source run_likelihood_scan_2d_kl_c2v.sh
```