# Compiler
NVCC = nvcc

# Compiler flags
NVCCFLAGS = -arch=sm_30

# Linker flags
LDFLAGS = -lm

# Source files
SRCS = main.cu

# Object files
OBJS = $(SRCS:.cu=.o)

# Executable name
EXEC = monte-carlo-cuda

# Build target
all: $(EXEC)

$(EXEC): $(OBJS)
	$(NVCC) $(NVCCFLAGS) $(LDFLAGS) $^ -o $@

%.o: %.cu
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

.PHONY: clean
# Clean target
clean:
	rm -f $(OBJS) $(EXEC)

.PHONY: Build
# Compile targets and build dockerfile
build:
	docker build -t monte-carlo-cuda .


.PHONY: deploy
# Create kubernetes cluster and deploy gpu operator
deploy:
	eksctl create cluster -f eks-cluster.yaml
	# connect to kubernetes cluster
	eksctl utils write-kubeconfig --cluster=hpc-ai-demo
	# install nvidia gpu operator
	kubectl create ns gpu-operator
	kubectl label --overwrite ns gpu-operator pod-security.kubernetes.io/enforce=privileged
	kubectl create -f https://raw.githubusercontent.com/NVIDIA/gpu-operator/master/deploy/v1.0.0-beta4/