CURRENT_DIR = $(shell pwd)
SUPPORTING_PATH = $(CURRENT_DIR)/../../tests/supportingResources/

.PHONY: all

tfinit:
		echo "[info]: Initialising the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform init
		echo "[info]: Initialising Example stack" ;\
		terraform init

tfplan:
		echo "[info]: Planning the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform plan
		echo "[info]: Planning Example stack" ;\
		terraform plan ;\

tfapply:
		echo "[info]: Creating/Updating the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform plan --out=plan.tmp ;\
		terraform apply plan.tmp ;\
		rm plan.tmp
		echo "[info]: Creating Example stack" ;\
		terraform plan --out=plan.tmp ;\
		terraform apply plan.tmp ;\
		rm plan.tmp

tfdestroy:
		terraform init ;\
		echo "[info]: Destroying Example stack" ;\
		terraform destroy --auto-approve
		echo "[info]: Destroying the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform init ;\
		terraform destroy --auto-approve


tests: tfinit tfapply
