import tensorflow as tf

INPUT_SHAPE = (1024, 1)

def passthrough_x3():
    input_frame = tf.keras.Input(shape=INPUT_SHAPE, dtype=tf.float32)
    output_frame = input_frame * 3
    model = tf.keras.Model(inputs=input_frame, outputs=output_frame)
    return model


if __name__ == "__main__":
    # Create and compile the model
    model = passthrough_x3()

    # Save the model in SavedModel format
    model.save('models/passthrough_model')
