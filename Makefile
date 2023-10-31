.PHONY: build
build:
	eksctl create cluster -f eks-cluster.yaml
	# connect to kubernetes cluster
	eksctl utils write-kubeconfig --cluster=hpc-ai-demo
	# install nvidia gpu operator
	kubectl create -f https://raw.githubusercontent.com/NVIDIA/gpu-operator/master/deploy/v1.0.0-beta4/
