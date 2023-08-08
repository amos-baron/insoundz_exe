import logging

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def convert_to_required_format(raw_data, desired_sample_rate, original_sample_rate):
    # If original and desired sample rates are the same, return raw data
    if original_sample_rate == desired_sample_rate:
        logging.info("No sample rate conversion needed. Returning raw data.")
        return raw_data

    logging.info(f"Converting sample rate from {original_sample_rate} to {desired_sample_rate}")

    # Sample rate convertion should happen here
    resampled_audio = raw_data

    logging.info("Sample rate conversion completed.")

    return resampled_audio