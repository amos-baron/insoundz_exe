üs
ō
Ä

8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype

MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool("
allow_missing_filesbool( 
?
Mul
x"T
y"T
z"T"
Ttype:
2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
³
PartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
Į
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring Ø
@
StaticRegexFullMatch	
input

output
"
patternstring
L

StringJoin
inputs*N

output"

Nint("
	separatorstring "serve*2.13.02v2.13.0-rc2-7-g1cb1a030a628F

serving_default_input_1Placeholder*,
_output_shapes
:’’’’’’’’’*
dtype0*!
shape:’’’’’’’’’
”
PartitionedCallPartitionedCallserving_default_input_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *,
_output_shapes
:’’’’’’’’’* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *)
f$R"
 __inference_signature_wrapper_49

NoOpNoOp

ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*Ó
valueÉBĘ Bæ
Õ
layer-0
layer-1
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
	_default_save_signature


signatures* 
* 

	keras_api* 
* 
* 
* 
®
non_trainable_variables

layers
metrics
layer_regularization_losses
layer_metrics
	variables
trainable_variables
regularization_losses
__call__
	_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses* 

trace_0
trace_1* 

trace_0
trace_1* 
* 

serving_default* 
* 
* 

0
1* 
* 
* 
* 
* 
* 
* 
* 
* 
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 

StatefulPartitionedCallStatefulPartitionedCallsaver_filenameConst*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *$
fR
__inference__traced_save_71

StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *'
f"R 
__inference__traced_restore_80ŗ7
ė
Z
=__inference_model_layer_call_and_return_conditional_losses_27
input_1
identity[
tf.math.multiply/Mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  @@|
tf.math.multiply/MulMulinput_1tf.math.multiply/Mul/y:output:0*
T0*,
_output_shapes
:’’’’’’’’’e
IdentityIdentitytf.math.multiply/Mul:z:0*
T0*,
_output_shapes
:’’’’’’’’’"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*+
_input_shapes
:’’’’’’’’’:U Q
,
_output_shapes
:’’’’’’’’’
!
_user_specified_name	input_1
¦
?
"__inference_model_layer_call_fn_43
input_1
identity®
PartitionedCallPartitionedCallinput_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *,
_output_shapes
:’’’’’’’’’* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *F
fAR?
=__inference_model_layer_call_and_return_conditional_losses_33e
IdentityIdentityPartitionedCall:output:0*
T0*,
_output_shapes
:’’’’’’’’’"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*+
_input_shapes
:’’’’’’’’’:U Q
,
_output_shapes
:’’’’’’’’’
!
_user_specified_name	input_1

=
 __inference_signature_wrapper_49
input_1
identity
PartitionedCallPartitionedCallinput_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *,
_output_shapes
:’’’’’’’’’* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *&
f!R
__inference__wrapped_model_21e
IdentityIdentityPartitionedCall:output:0*
T0*,
_output_shapes
:’’’’’’’’’"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*+
_input_shapes
:’’’’’’’’’:U Q
,
_output_shapes
:’’’’’’’’’
!
_user_specified_name	input_1
ä
:
__inference__wrapped_model_21
input_1
identitya
model/tf.math.multiply/Mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  @@
model/tf.math.multiply/MulMulinput_1%model/tf.math.multiply/Mul/y:output:0*
T0*,
_output_shapes
:’’’’’’’’’k
IdentityIdentitymodel/tf.math.multiply/Mul:z:0*
T0*,
_output_shapes
:’’’’’’’’’"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*+
_input_shapes
:’’’’’’’’’:U Q
,
_output_shapes
:’’’’’’’’’
!
_user_specified_name	input_1
¦
?
"__inference_model_layer_call_fn_38
input_1
identity®
PartitionedCallPartitionedCallinput_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *,
_output_shapes
:’’’’’’’’’* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *F
fAR?
=__inference_model_layer_call_and_return_conditional_losses_27e
IdentityIdentityPartitionedCall:output:0*
T0*,
_output_shapes
:’’’’’’’’’"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*+
_input_shapes
:’’’’’’’’’:U Q
,
_output_shapes
:’’’’’’’’’
!
_user_specified_name	input_1
ė
Z
=__inference_model_layer_call_and_return_conditional_losses_33
input_1
identity[
tf.math.multiply/Mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  @@|
tf.math.multiply/MulMulinput_1tf.math.multiply/Mul/y:output:0*
T0*,
_output_shapes
:’’’’’’’’’e
IdentityIdentitytf.math.multiply/Mul:z:0*
T0*,
_output_shapes
:’’’’’’’’’"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*+
_input_shapes
:’’’’’’’’’:U Q
,
_output_shapes
:’’’’’’’’’
!
_user_specified_name	input_1

h
__inference__traced_save_71
file_prefix
savev2_const

identity_1¢MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPHo
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B Ų
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0savev2_const"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 *
dtypes
2
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:³
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: 7
NoOpNoOp^MergeV2Checkpoints*
_output_shapes
 "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 2(
MergeV2CheckpointsMergeV2Checkpoints:=9

_output_shapes
: 

_user_specified_nameConst:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix

D
__inference__traced_restore_80
file_prefix

identity_1
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPHr
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B £
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*
_output_shapes
:*
dtypes
2Y
NoOpNoOp"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 X
IdentityIdentityfile_prefix^NoOp"/device:CPU:0*
T0*
_output_shapes
: J

Identity_1IdentityIdentity:output:0*
T0*
_output_shapes
: "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: :C ?

_output_shapes
: 
%
_user_specified_namefile_prefix"ŹJ
saver_filename:0StatefulPartitionedCall:0StatefulPartitionedCall_18"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*µ
serving_default”
@
input_15
serving_default_input_1:0’’’’’’’’’A
tf.math.multiply-
PartitionedCall:0’’’’’’’’’tensorflow/serving/predict: 
ī
layer-0
layer-1
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
	_default_save_signature


signatures"
_tf_keras_network
"
_tf_keras_input_layer
(
	keras_api"
_tf_keras_layer
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
Ź
non_trainable_variables

layers
metrics
layer_regularization_losses
layer_metrics
	variables
trainable_variables
regularization_losses
__call__
	_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
·
trace_0
trace_12
"__inference_model_layer_call_fn_38
"__inference_model_layer_call_fn_43µ
®²Ŗ
FullArgSpec)
args!
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults¢
p 

 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 ztrace_0ztrace_1
ķ
trace_0
trace_12¶
=__inference_model_layer_call_and_return_conditional_losses_27
=__inference_model_layer_call_and_return_conditional_losses_33µ
®²Ŗ
FullArgSpec)
args!
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults¢
p 

 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 ztrace_0ztrace_1
ČBÅ
__inference__wrapped_model_21input_1"
²
FullArgSpec
args 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 
,
serving_default"
signature_map
"
_generic_user_object
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
źBē
"__inference_model_layer_call_fn_38input_1"µ
®²Ŗ
FullArgSpec)
args!
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults¢
p 

 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 
źBē
"__inference_model_layer_call_fn_43input_1"µ
®²Ŗ
FullArgSpec)
args!
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults¢
p 

 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 
B
=__inference_model_layer_call_and_return_conditional_losses_27input_1"µ
®²Ŗ
FullArgSpec)
args!
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults¢
p 

 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 
B
=__inference_model_layer_call_and_return_conditional_losses_33input_1"µ
®²Ŗ
FullArgSpec)
args!
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults¢
p 

 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 
ĒBÄ
 __inference_signature_wrapper_49input_1"
²
FullArgSpec
args 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsŖ *
 £
__inference__wrapped_model_215¢2
+¢(
&#
input_1’’’’’’’’’
Ŗ "HŖE
C
tf.math.multiply/,
tf_math_multiply’’’’’’’’’³
=__inference_model_layer_call_and_return_conditional_losses_27r=¢:
3¢0
&#
input_1’’’’’’’’’
p

 
Ŗ "1¢.
'$
tensor_0’’’’’’’’’
 ³
=__inference_model_layer_call_and_return_conditional_losses_33r=¢:
3¢0
&#
input_1’’’’’’’’’
p 

 
Ŗ "1¢.
'$
tensor_0’’’’’’’’’
 
"__inference_model_layer_call_fn_38g=¢:
3¢0
&#
input_1’’’’’’’’’
p

 
Ŗ "&#
unknown’’’’’’’’’
"__inference_model_layer_call_fn_43g=¢:
3¢0
&#
input_1’’’’’’’’’
p 

 
Ŗ "&#
unknown’’’’’’’’’±
 __inference_signature_wrapper_49@¢=
¢ 
6Ŗ3
1
input_1&#
input_1’’’’’’’’’"HŖE
C
tf.math.multiply/,
tf_math_multiply’’’’’’’’’